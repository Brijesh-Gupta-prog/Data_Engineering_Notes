# Python Intermediate - Learning Guide

This folder contains Jupyter notebooks that build upon the basics from the "05 Python" folder. These notebooks cover intermediate Python concepts essential for data engineering and prepare you for learning PySpark.

## How to Use These Notebooks

1. **Complete 05 Python first** - Make sure you've finished all notebooks in the "05 Python" folder
2. **Open the notebooks** in Jupyter Notebook, JupyterLab, or VS Code with Jupyter extension
3. **Read the markdown cells** - they contain theory and explanations
4. **Run the code cells** - click on a cell and press `Shift + Enter` to execute
5. **Work through in order** - start with `12_file_handling.ipynb` and progress sequentially
6. **Experiment** - try modifying the code to see what happens!

## Notebook Guide

### 12_file_handling.ipynb
- Reading text files
- Writing text files
- Reading CSV files
- Writing CSV files
- Working with file paths
- **Why it matters**: Data engineering involves reading and writing data files constantly

### 13_error_handling.ipynb
- Understanding different types of errors
- Using try-except blocks
- Handling specific error types
- Using finally blocks
- **Why it matters**: Real-world data is messy and unpredictable - you need robust error handling

### 14_list_comprehensions.ipynb
- Basic list comprehensions
- List comprehensions with conditions
- Nested list comprehensions
- When to use list comprehensions vs loops
- **Why it matters**: Pythonic way to transform data, similar to PySpark DataFrame transformations

### 15_lambda_functions.ipynb
- Creating lambda functions
- Using lambda with map, filter, and reduce
- Lambda functions in sorting
- When to use lambda vs regular functions
- **Why it matters**: Lambda functions are heavily used in PySpark for DataFrame operations

### 16_tuples_sets.ipynb
- Creating and using tuples
- Tuple operations and methods
- Creating and using sets
- Set operations (union, intersection, difference)
- **Why it matters**: Understanding different data structures helps with data processing

### 17_modules_packages.ipynb
- Importing built-in modules
- Using module functions
- Creating your own modules
- Importing specific functions
- Understanding packages
- **Why it matters**: You'll import PySpark, pandas, and other libraries as packages

### 18_datetime.ipynb
- Creating date and time objects
- Formatting dates
- Parsing dates from strings
- Calculating time differences
- Working with date ranges
- **Why it matters**: Time-series data is common in data engineering

### 19_data_processing_example.ipynb
- Complete example combining all concepts
- Reading and processing CSV data
- Data cleaning and transformation
- Error handling
- Writing processed data
- **Why it matters**: Real-world data processing example that mirrors PySpark workflows

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

## Connection to PySpark

The concepts in these notebooks directly relate to PySpark:

- **File Handling** → PySpark reads/writes DataFrames from/to files
- **List Comprehensions** → PySpark DataFrame transformations (select, filter, map)
- **Lambda Functions** → PySpark UDFs (User Defined Functions) and transformations
- **Error Handling** → Essential for robust data pipelines
- **Modules/Packages** → You'll import `pyspark.sql` and other modules
- **DateTime** → PySpark has extensive date/time functions for DataFrames
- **Data Processing** → PySpark DataFrames are the distributed version of what we do here

## Next Steps

After completing these notebooks, you'll be ready to:
- Learn PySpark fundamentals
- Work with DataFrames and transformations
- Understand distributed data processing
- Build data engineering pipelines

## Tips for Success

1. **Practice regularly** - Run the code cells and experiment
2. **Understand the concepts** - Don't just copy code, understand why it works
3. **Connect to data engineering** - Think about how each concept applies to processing large datasets
4. **Review previous notebooks** - Concepts build on each other
5. **Ask questions** - If something doesn't make sense, review or ask for help

Happy learning! 🐍📊

