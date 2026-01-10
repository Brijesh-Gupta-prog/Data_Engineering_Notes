# NumPy for Data Engineering - Learning Guide

This folder contains Jupyter notebooks that teach NumPy, the fundamental Python library for numerical computing. These notebooks are designed for data engineering freshers and can be completed in a single day.

## How to Use These Notebooks

1. **Complete Python basics first** - Make sure you've finished notebooks in "05 Python", "06 Python", and "07 Python" folders
2. **Open the notebooks** in Jupyter Notebook, JupyterLab, or VS Code with Jupyter extension
3. **Read the markdown cells** - they contain theory and explanations
4. **Run the code cells** - click on a cell and press `Shift + Enter` to execute
5. **Work through in order** - start with `01_numpy_introduction.ipynb` and progress sequentially
6. **Experiment** - try modifying the code to see what happens!

## Installation

Before starting, make sure NumPy is installed:

```bash
pip install numpy
```

## Notebook Guide

### 01_numpy_introduction.ipynb
- What is NumPy?
- Why NumPy for data engineering?
- Understanding arrays vs Python lists
- Installing NumPy
- Basic array creation
- Array attributes (shape, dtype, size)
- **Why it matters**: NumPy is the foundation for all numerical computing in Python, including Pandas

### 02_array_creation_basics.ipynb
- Creating arrays from lists
- Creating arrays with zeros, ones, empty
- Creating arrays with arange, linspace, logspace
- Creating arrays with random numbers
- Array data types (dtypes)
- Type conversion
- **Why it matters**: Understanding array creation is essential for data initialization and manipulation

### 03_array_operations_indexing.ipynb
- Array indexing (single element, slicing)
- Boolean indexing
- Fancy indexing
- Array slicing and views vs copies
- Modifying arrays
- Array comparison operations
- **Why it matters**: Indexing and slicing are fundamental operations for data selection and manipulation

### 04_mathematical_operations.ipynb
- Element-wise operations
- Universal functions (ufuncs)
- Mathematical functions (sin, cos, exp, log, etc.)
- Statistical functions (mean, std, min, max, etc.)
- Aggregation functions
- Array arithmetic
- **Why it matters**: Mathematical operations are core to data processing and analysis

### 05_array_manipulation.ipynb
- Reshaping arrays
- Flattening arrays
- Transposing arrays
- Stacking arrays (vstack, hstack, concatenate)
- Splitting arrays
- Adding/removing dimensions
- **Why it matters**: Data often needs to be reshaped for different operations and model inputs

### 06_broadcasting.ipynb
- Understanding broadcasting rules
- Broadcasting examples
- When broadcasting works and when it doesn't
- Practical broadcasting scenarios
- **Why it matters**: Broadcasting enables efficient operations on arrays of different shapes

### 07_linear_algebra.ipynb
- Matrix multiplication
- Dot product
- Vector operations
- Matrix operations (transpose, inverse, determinant)
- Solving linear equations
- Eigenvalues and eigenvectors (introduction)
- **Why it matters**: Linear algebra is fundamental for machine learning and data transformations

### 08_practical_example.ipynb
- Complete end-to-end data engineering example using NumPy
- Data preprocessing
- Feature engineering
- Data normalization
- Statistical analysis
- **Why it matters**: Real-world projects combine all NumPy concepts

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

NumPy is essential for data engineering because:

- **Performance** → NumPy arrays are 10-100x faster than Python lists for numerical operations
- **Memory Efficiency** → NumPy uses less memory than Python lists
- **Foundation for Pandas** → Pandas DataFrames are built on NumPy arrays
- **Scientific Computing** → Essential for numerical computations, transformations, and preprocessing
- **Machine Learning** → Most ML libraries (scikit-learn, TensorFlow, PyTorch) use NumPy arrays
- **Data Preprocessing** → Normalization, scaling, and feature engineering rely on NumPy
- **Vectorization** → Enables efficient batch operations on large datasets

## Learning Path for One Day

**Morning Session (3-4 hours):**
1. 01_numpy_introduction.ipynb (30 min)
2. 02_array_creation_basics.ipynb (45 min)
3. 03_array_operations_indexing.ipynb (45 min)
4. 04_mathematical_operations.ipynb (60 min)

**Afternoon Session (3-4 hours):**
5. 05_array_manipulation.ipynb (45 min)
6. 06_broadcasting.ipynb (45 min)
7. 07_linear_algebra.ipynb (60 min)
8. 08_practical_example.ipynb (60 min)
9. 09_exercise.ipynb (60 min)
10. 10_exercise_solution.ipynb (30 min - review)

## Tips for Success

1. **Practice regularly** - Run the code cells and experiment with different values
2. **Understand the concepts** - Don't just copy code, understand why it works
3. **Connect to data engineering** - Think about how each operation applies to data preprocessing
4. **Review previous notebooks** - Concepts build on each other
5. **Ask questions** - If something doesn't make sense, review or ask for help
6. **Experiment** - Try modifying examples to see what happens
7. **Take notes** - Write down important concepts and common patterns
8. **Visualize** - Use matplotlib to visualize arrays when helpful

## Common NumPy Operations Cheat Sheet

```python
import numpy as np

# Array creation
arr = np.array([1, 2, 3])
arr = np.zeros((3, 4))
arr = np.ones((2, 3))
arr = np.arange(0, 10, 2)
arr = np.linspace(0, 1, 5)
arr = np.random.rand(3, 4)

# Array attributes
arr.shape      # Dimensions
arr.dtype      # Data type
arr.size       # Total elements
arr.ndim       # Number of dimensions

# Indexing and slicing
arr[0]         # First element
arr[1:3]       # Slice
arr[arr > 5]   # Boolean indexing
arr[[0, 2, 4]] # Fancy indexing

# Mathematical operations
np.mean(arr)   # Mean
np.std(arr)    # Standard deviation
np.sum(arr)    # Sum
np.max(arr)    # Maximum
np.min(arr)    # Minimum

# Array manipulation
arr.reshape(2, 3)  # Reshape
arr.flatten()      # Flatten
arr.T              # Transpose
np.concatenate([arr1, arr2])  # Concatenate
np.vstack([arr1, arr2])       # Vertical stack
np.hstack([arr1, arr2])       # Horizontal stack

# Linear algebra
np.dot(a, b)       # Dot product
np.matmul(a, b)    # Matrix multiplication
np.linalg.inv(a)   # Matrix inverse
np.linalg.det(a)   # Determinant
```

## NumPy vs Python Lists

| Feature | Python Lists | NumPy Arrays |
|---------|-------------|--------------|
| **Speed** | Slower for numerical operations | 10-100x faster |
| **Memory** | More memory usage | Less memory usage |
| **Data Types** | Can mix types | Homogeneous (same type) |
| **Operations** | Element-wise loops needed | Vectorized operations |
| **Size** | Dynamic, can grow | Fixed size (more efficient) |
| **Use Case** | General purpose | Numerical computing |

## Next Steps

After completing these notebooks, you'll be ready to:
- Work with Pandas (which uses NumPy under the hood)
- Perform efficient numerical computations
- Preprocess data for machine learning
- Understand how data science libraries work internally
- Optimize data processing pipelines
- Learn advanced NumPy features for specific use cases

Happy learning! 🔢📊

