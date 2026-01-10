# Python Advanced Fundamentals - Learning Guide

This folder contains Jupyter notebooks that cover Object-Oriented Programming (OOP) and JSON handling. These are essential concepts for data engineering and will help you understand how to structure code and work with JSON data formats commonly used in APIs and data pipelines.

## How to Use These Notebooks

1. **Complete 05 Python and 06 Python first** - Make sure you've finished all notebooks in the previous folders
2. **Open the notebooks** in Jupyter Notebook, JupyterLab, or VS Code with Jupyter extension
3. **Read the markdown cells** - they contain theory and explanations
4. **Run the code cells** - click on a cell and press `Shift + Enter` to execute
5. **Work through in order** - start with `23_classes_objects.ipynb` and progress sequentially
6. **Experiment** - try modifying the code to see what happens!

## Notebook Guide

### 23_classes_objects.ipynb
- Understanding classes and objects
- Creating classes
- Instance variables and methods
- The `__init__` method (constructor)
- Class attributes vs instance attributes
- **Why it matters**: OOP helps organize code and is used in many Python libraries

### 24_inheritance.ipynb
- Understanding inheritance
- Creating child classes
- Method overriding
- The `super()` function
- Multiple inheritance basics
- **Why it matters**: Inheritance promotes code reuse and is fundamental to Python's design

### 25_json_handling.ipynb
- What is JSON?
- Reading JSON from strings
- Writing JSON to strings
- Reading JSON from files
- Writing JSON to files
- **Why it matters**: JSON is the most common data format for APIs and data exchange

### 26_json_advanced.ipynb
- Working with nested JSON
- Handling JSON arrays
- JSON validation
- Pretty printing JSON
- Converting between JSON and Python objects
- **Why it matters**: Real-world JSON data is often complex and nested

### 27_oop_json_example.ipynb
- Complete example combining OOP and JSON
- Creating classes to represent data structures
- Serializing objects to JSON
- Deserializing JSON to objects
- **Why it matters**: Real-world applications combine OOP and JSON for data processing

### 28_exercise.ipynb
- Exercises covering OOP concepts
- Exercises covering JSON handling
- Combined exercises
- **Why it matters**: Practice reinforces learning and builds confidence

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

The concepts in these notebooks directly relate to data engineering:

- **OOP** → Many data engineering libraries (pandas, PySpark) use OOP concepts. Understanding classes helps you understand how these libraries work
- **JSON** → APIs return JSON data, configuration files are often JSON, and data pipelines frequently process JSON
- **Combined** → You'll create classes to represent data structures and serialize/deserialize them as JSON

## Next Steps

After completing these notebooks, you'll be ready to:
- Learn pandas for data manipulation
- Work with APIs that return JSON data
- Understand how Python libraries are structured (they use OOP)
- Build more complex data processing applications

## Tips for Success

1. **Practice regularly** - Run the code cells and experiment
2. **Understand the concepts** - Don't just copy code, understand why it works
3. **Connect to data engineering** - Think about how each concept applies to processing data
4. **Review previous notebooks** - Concepts build on each other
5. **Ask questions** - If something doesn't make sense, review or ask for help

Happy learning! 🐍📊

