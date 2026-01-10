# Pandas for Data Engineering - Learning Guide

This folder contains Jupyter notebooks that teach pandas, the most important Python library for data manipulation and analysis. These notebooks are designed for data engineering freshers and can be completed in a single day.

## How to Use These Notebooks

1. **Complete Python basics first** - Make sure you've finished notebooks in "05 Python", "06 Python", and "07 Python" folders
2. **Open the notebooks** in Jupyter Notebook, JupyterLab, or VS Code with Jupyter extension
3. **Read the markdown cells** - they contain theory and explanations
4. **Run the code cells** - click on a cell and press `Shift + Enter` to execute
5. **Work through in order** - start with `01_pandas_introduction.ipynb` and progress sequentially
6. **Experiment** - try modifying the code to see what happens!

## Installation

Before starting, make sure pandas is installed:

```bash
pip install pandas
```

For reading Excel files, you'll also need:
```bash
pip install openpyxl
```

## Notebook Guide

### 01_pandas_introduction.ipynb
- What is pandas?
- Installing pandas
- Understanding Series (1D data)
- Understanding DataFrames (2D data)
- Creating DataFrames from dictionaries and lists
- Basic DataFrame operations
- **Why it matters**: DataFrames are the foundation of data manipulation in pandas

### 02_reading_writing_data.ipynb
- Reading CSV files
- Writing CSV files
- Reading Excel files
- Writing Excel files
- Reading JSON files
- Writing JSON files
- Handling different file encodings
- **Why it matters**: Data engineers constantly read and write data from various sources

### 03_data_selection_filtering.ipynb
- Selecting columns
- Selecting rows by index
- Selecting rows by condition (filtering)
- Using loc and iloc
- Boolean indexing
- Multiple conditions
- **Why it matters**: Selecting and filtering are the most common operations in data engineering

### 04_data_cleaning.ipynb
- Identifying missing values
- Handling missing values (drop, fill)
- Finding and removing duplicates
- Converting data types
- Renaming columns
- Reordering columns
- **Why it matters**: Real-world data is messy - cleaning is essential before analysis

### 05_data_transformation.ipynb
- GroupBy operations
- Merging DataFrames (inner, outer, left, right joins)
- Concatenating DataFrames
- Pivot tables
- Applying functions to columns
- **Why it matters**: Data transformation is core to ETL processes

### 06_data_aggregation.ipynb
- Basic aggregations (sum, mean, count, etc.)
- Custom aggregations
- Multiple aggregations
- Window functions
- Rolling calculations
- **Why it matters**: Aggregations are essential for data analysis and reporting

### 07_datetime_operations.ipynb
- Converting strings to datetime
- Extracting date components (year, month, day)
- Date arithmetic
- Filtering by date ranges
- Resampling time series data
- **Why it matters**: Time-series data is common in data engineering

### 08_practical_example.ipynb
- Complete end-to-end data engineering example
- Reading multiple data sources
- Data cleaning and transformation
- Data validation
- Writing processed data
- **Why it matters**: Real-world projects combine all concepts

### 09_exercise.ipynb
- Hands-on exercises covering all concepts
- Progressive difficulty
- Practice problems to test your understanding
- **Why it matters**: Practice reinforces learning and builds confidence

### 10_exercise_solution.ipynb
- Complete solutions to all exercises from 09_exercise.ipynb
- Step-by-step explanations
- Alternative approaches and tips
- **Why it matters**: Compare your solutions and learn different approaches

### 11_pandas_vs_spark.ipynb
- Understanding differences between Pandas and Spark
- When to use Pandas vs Spark
- Code comparison examples
- Real-world decision guide
- Learning path recommendations
- **Why it matters**: Helps you choose the right tool and understand the big data landscape

## Running the Notebooks

### Option 1: Jupyter Notebook
```bash
jupyter notebook
```
Then navigate to the notebook you want to open.

### Option 2: JupyterLab
```bash
jupyter lab
```

### Option 3: VS Code
- Install the Jupyter extension
- Open the `.ipynb` file
- Click "Run Cell" or press `Shift + Enter`

## Notebook Structure

Each notebook is organized with:
- **Markdown cells** - Theory, explanations, and learning objectives
- **Code cells** - Executable Python code with comments
- **Progressive difficulty** - Concepts build upon each other
- **Practical examples** - Real-world scenarios relevant to data engineering

## Connection to Data Engineering

Pandas is essential for data engineering because:

- **DataFrames** → Similar to SQL tables, making it easy to work with structured data
- **Data Cleaning** → Real-world data always needs cleaning before processing
- **Data Transformation** → ETL processes require transforming data from source to target format
- **Data Aggregation** → Reporting and analytics require aggregating data
- **File I/O** → Data engineers read from and write to various file formats
- **Performance** → Pandas is optimized for data manipulation operations

## Learning Path for One Day

**Morning Session (3-4 hours):**
1. 01_pandas_introduction.ipynb (30 min)
2. 02_reading_writing_data.ipynb (45 min)
3. 03_data_selection_filtering.ipynb (45 min)
4. 04_data_cleaning.ipynb (60 min)

**Afternoon Session (3-4 hours):**
5. 05_data_transformation.ipynb (60 min)
6. 06_data_aggregation.ipynb (45 min)
7. 07_datetime_operations.ipynb (45 min)
8. 08_practical_example.ipynb (60 min)
9. 09_exercise.ipynb (60 min)
10. 10_exercise_solution.ipynb (30 min - review)
11. 11_pandas_vs_spark.ipynb (30 min - overview)

## Tips for Success

1. **Practice regularly** - Run the code cells and experiment with different values
2. **Understand the concepts** - Don't just copy code, understand why it works
3. **Connect to data engineering** - Think about how each operation applies to ETL processes
4. **Review previous notebooks** - Concepts build on each other
5. **Ask questions** - If something doesn't make sense, review or ask for help
6. **Experiment** - Try modifying examples to see what happens
7. **Take notes** - Write down important concepts and common patterns

## Common Pandas Operations Cheat Sheet

```python
# Reading data
df = pd.read_csv('file.csv')
df = pd.read_excel('file.xlsx')
df = pd.read_json('file.json')

# Basic info
df.head()           # First 5 rows
df.info()           # Data types and null counts
df.describe()       # Statistical summary
df.shape            # (rows, columns)

# Selection
df['column']        # Single column
df[['col1', 'col2']] # Multiple columns
df.loc[row, col]    # Label-based selection
df.iloc[row, col]   # Position-based selection

# Filtering
df[df['column'] > 100]
df[(df['col1'] > 100) & (df['col2'] == 'value')]

# Cleaning
df.dropna()         # Remove rows with nulls
df.fillna(0)        # Fill nulls with 0
df.drop_duplicates() # Remove duplicates

# Transformation
df.groupby('column').sum()
pd.merge(df1, df2, on='key')
pd.concat([df1, df2])
df.pivot_table(values='val', index='row', columns='col')
```

## Next Steps

After completing these notebooks, you'll be ready to:
- Work with real-world data engineering projects
- Process large datasets efficiently
- Clean and transform data for analytics
- Integrate pandas into data pipelines
- Learn PySpark (similar concepts, distributed processing)
- Understand when to use Pandas vs Spark for different scenarios

Happy learning! 🐼📊

