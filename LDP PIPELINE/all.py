import dlt

from pyspark.sql.functions import (
    current_timestamp,
    col,
    trim,
    upper,
    lower,
    to_timestamp,
    when,
    row_number
)
from pyspark.sql.types import DecimalType, IntegerType
from pyspark.sql.window import Window

from pyspark.sql.functions import (
    sum,
    count,
    countDistinct,
    avg,
    min,
    max,
    when,
    lit,
    upper
)


@dlt.table(
    name="bronze_products",
    comment="Raw products data ingested from JSON files"
)
def bronze_products():
    return (
        spark.readStream
            .format("cloudFiles")
            .option("cloudFiles.format", "json")
            .option("cloudFiles.inferColumnTypes", "true")
            .option("cloudFiles.schemaEvolutionMode", "addNewColumns")
            .option("rescuedDataColumn", "_rescued_data")
            .load("/Volumes/ldp_exercise/exercise_schema/raw/products/")
            .withColumn("_ingest_ts", current_timestamp())
            .withColumn("_source_file", col("_metadata.file_path"))
    )




@dlt.table(
    name="bronze_customers",
    comment="Raw customers data ingested from JSON files"
)
def bronze_customers():
    return (
        spark.readStream
            .format("cloudFiles")
            .option("cloudFiles.format", "json")
            .option("cloudFiles.inferColumnTypes", "true")
            .option("cloudFiles.schemaEvolutionMode", "addNewColumns")
            .option("rescuedDataColumn", "_rescued_data")
            .load("/Volumes/ldp_exercise/exercise_schema/raw/customers/")
            .withColumn("_ingest_ts", current_timestamp())
            .withColumn("_source_file", col("_metadata.file_path"))
    )


@dlt.table(
    name="bronze_orders",
    comment="Raw orders data ingested from JSON files"
)
def bronze_orders():
    return (
        spark.readStream
            .format("cloudFiles")
            .option("cloudFiles.format", "json")
            .option("cloudFiles.inferColumnTypes", "true")
            .option("rescuedDataColumn", "_rescued_data")
            .load("/Volumes/ldp_exercise/exercise_schema/raw/orders/")
            .withColumn("_ingest_ts", current_timestamp())
            .withColumn("_source_file", col("_metadata.file_path"))
    )


@dlt.table(
    name="bronze_payments",
    comment="Raw payments data ingested from JSON files"
)
def bronze_payments():
    return (
        spark.readStream
            .format("cloudFiles")
            .option("cloudFiles.format", "json")
            .option("cloudFiles.inferColumnTypes", "true")
            .option("rescuedDataColumn", "_rescued_data")
            .load("/Volumes/ldp_exercise/exercise_schema/raw/payments/")
            .withColumn("_ingest_ts", current_timestamp())
            .withColumn("_source_file", col("_metadata.file_path"))
    )



@dlt.table(
    name="silver_products",
    comment="Cleaned and validated product catalog"
)
@dlt.expect_or_drop("valid_price", "price > 0")
@dlt.expect_or_drop("valid_product_id", "product_id IS NOT NULL")
def silver_products():

    df = dlt.read("bronze_products")

    df = (
        df
        .withColumn("price", col("price").cast(DecimalType(10, 2)))
        .withColumn("stock_quantity", col("stock_quantity").cast(IntegerType()))
        .withColumn("category", lower(trim(col("category"))))
        .withColumn("created_at", to_timestamp("created_at"))
        .withColumn(
            "stock_quantity",
            when(col("stock_quantity").isNull(), 0).otherwise(col("stock_quantity"))
        )
    )

    window = Window.partitionBy("product_id").orderBy(col("_ingest_ts").desc())

    return (
        df.withColumn("rn", row_number().over(window))
          .filter(col("rn") == 1)
          .drop("rn", "_rescued_data")
    )




@dlt.table(
    name="silver_customers",
    comment="Cleaned and validated customers"
)
@dlt.expect_or_drop(
    "valid_email",
    "email RLIKE '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'"
)
@dlt.expect_or_drop(
    "valid_customer_id",
    "customer_id IS NOT NULL"
)
def silver_customers():

    df = dlt.read("bronze_customers")

    df = (
        df
        .withColumn("email", lower(trim(col("email"))))
        .withColumn("state", upper(trim(col("state"))))
        .withColumn("created_at", to_timestamp("created_at"))
    )

    window = Window.partitionBy("customer_id").orderBy(col("_ingest_ts").desc())

    return (
        df.withColumn("rn", row_number().over(window))
          .filter(col("rn") == 1)
          .drop("rn", "_rescued_data")
    )



@dlt.table(
    name="silver_orders",
    comment="Validated orders with customer integrity enforced"
)
@dlt.expect_or_drop("valid_amount", "total_amount >= 0")
def silver_orders():

    orders = dlt.read("bronze_orders")
    customers = dlt.read("silver_customers")

    orders = (
        orders
        .withColumn("order_date", to_timestamp("order_date"))
        .withColumn("total_amount", col("total_amount").cast(DecimalType(10, 2)))
        .withColumn("status", lower(trim(col("status"))))
        .filter(col("order_date").isNotNull())
    )

    valid_orders = orders.join(
        customers.select("customer_id"),
        on="customer_id",
        how="inner"
    )

    window = Window.partitionBy("order_id").orderBy(col("_ingest_ts").desc())

    return (
        valid_orders
        .withColumn("rn", row_number().over(window))
        .filter(col("rn") == 1)
        .drop("rn", "_rescued_data")
    )



@dlt.table(
    name="silver_payments",
    comment="Validated payments linked to valid orders"
)
@dlt.expect_or_drop("valid_amount", "amount > 0")
def silver_payments():

    payments = dlt.read("bronze_payments")
    orders = dlt.read("silver_orders")

    payments = (
        payments
        .withColumn("payment_date", to_timestamp("payment_date"))
        .withColumn("amount", col("amount").cast(DecimalType(10, 2)))
        .withColumn("payment_status", lower(trim(col("payment_status"))))
        .filter(col("payment_date").isNotNull())
    )

    valid_payments = payments.join(
        orders.select("order_id"),
        on="order_id",
        how="inner"
    )

    window = Window.partitionBy("payment_id").orderBy(col("_ingest_ts").desc())

    return (
        valid_payments
        .withColumn("rn", row_number().over(window))
        .filter(col("rn") == 1)
        .drop("rn", "_rescued_data")
    )



@dlt.table(
    name="sales_summary_dashboard",
    comment="Daily sales metrics for dashboard consumption"
)
def sales_summary_dashboard():
    orders = dlt.read("silver_orders")

    # Filter only valid orders
    orders_filtered = (
        orders
        .filter(col("total_amount") > 0)
        .filter(col("status").isin("delivered", "shipped", "processing", "cancelled"))
        .filter(col("order_date").isNotNull())
        .withColumn("sale_date", col("order_date").cast("date"))
    )

    return (
        orders_filtered.groupBy("sale_date")
        .agg(
            sum("total_amount").alias("total_revenue"),
            count("*").alias("total_orders"),
            (sum("total_amount") / count("*")).alias("avg_order_value"),
            countDistinct("customer_id").alias("total_customers"),
            sum(when(col("status") == "delivered", 1).otherwise(0)).alias("completed_orders"),
            sum(when(col("status") == "cancelled", 1).otherwise(0)).alias("cancelled_orders")
        )
    )




@dlt.table(
    name="customer_analytics_dashboard",
    comment="Customer-level analytics for dashboard consumption"
)
def customer_analytics_dashboard():
    customers = dlt.read("silver_customers")
    orders = dlt.read("silver_orders")

    # Filter valid customers
    customers_filtered = (
        customers
        .filter(col("email").contains("@"))
        .filter(
            col("address").isNotNull() &
            col("city").isNotNull() &
            col("state").isNotNull() &
            col("zip_code").isNotNull()
        )
    )

    # Filter valid orders
    orders_filtered = (
        orders
        .filter(col("total_amount") > 0)
        .filter(col("status").isin("delivered", "shipped"))
    )

    # Aggregate per customer
    customer_stats = (
        orders_filtered.groupBy("customer_id")
        .agg(
            count("*").alias("total_orders"),
            sum("total_amount").alias("total_spent"),
            avg("total_amount").alias("avg_order_value"),
            min("order_date").alias("first_order_date"),
            max("order_date").alias("last_order_date")
        )
    )

    return (
        customers_filtered.join(customer_stats, on="customer_id", how="inner")
        .withColumn("customer_state", upper(col("state")))
        .withColumn("customer_name", col("name"))
        .withColumn("customer_lifetime_value", col("total_spent"))
        .select(
            "customer_id",
            "customer_name",
            "customer_state",
            "total_orders",
            "total_spent",
            "avg_order_value",
            "first_order_date",
            "last_order_date",
            "customer_lifetime_value"
        )
    )




import dlt
from pyspark.sql.functions import col, when, lit

@dlt.table(
    name="product_performance_dashboard",
    comment="Product-level performance metrics for dashboard consumption"
)
def product_performance_dashboard():
    products = dlt.read("silver_products")

    # Filter valid products
    products_filtered = (
        products
        .filter(col("price") > 0)  # Only positive prices
        .filter(col("sku").isNotNull() & (col("sku") != ""))  # Non-empty SKU
        .withColumn("stock_quantity", when(col("stock_quantity") < 0, 0).otherwise(col("stock_quantity")))
    )

    # Since order items are not available, we cannot calculate revenue or units sold
    products_dashboard = (
        products_filtered
        .withColumn("total_revenue", lit(None).cast("decimal(10,2)"))  # NULL revenue
        .withColumn("total_units_sold", lit(None).cast("bigint"))        # NULL units sold
        .withColumn("is_in_stock", col("stock_quantity") > 0)
        .withColumn("is_active", (col("price") > 0) & (col("sku").isNotNull()))
        .select(
            "product_id",
            col("name").alias("product_name"),
            "category",
            "price",
            "stock_quantity",
            "total_revenue",
            "total_units_sold",
            "is_in_stock",
            "is_active"
        )
    )

    return products_dashboard




@dlt.table(
    name="payment_analytics_dashboard",
    comment="Payment transaction analytics for dashboard consumption"
)
def payment_analytics_dashboard():
    payments = dlt.read("silver_payments")
    orders = dlt.read("silver_orders")

    # Filter valid payments
    valid_methods = ["credit_card", "debit_card", "paypal", "bank_transfer", "cash"]
    payments_filtered = (
        payments
        .filter(col("amount") > 0)
        .filter(col("payment_method").isin(valid_methods))
        .filter(col("payment_date").isNotNull())
    )

    # Keep only payments linked to valid orders
    payments_valid_orders = payments_filtered.join(
        orders.select("order_id"),
        on="order_id",
        how="inner"
    ).withColumn("payment_date_only", col("payment_date").cast("date"))

    # Aggregate per day and payment method
    payment_stats = payments_valid_orders.groupBy("payment_date_only", "payment_method").agg(
        count("*").alias("total_transactions"),
        sum("amount").alias("total_amount"),
        sum(when(col("payment_status") == "completed", 1).otherwise(0)).alias("successful_transactions"),
        sum(when(col("payment_status") == "failed", 1).otherwise(0)).alias("failed_transactions"),
        sum(when(col("payment_status") == "refunded", 1).otherwise(0)).alias("refunded_transactions")
    )

    return payment_stats.withColumn(
        "success_rate",
        (col("successful_transactions") / col("total_transactions") * 100)
    ).withColumnRenamed("payment_date_only", "payment_date")




