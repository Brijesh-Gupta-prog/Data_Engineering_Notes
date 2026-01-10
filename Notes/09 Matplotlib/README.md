# Matplotlib for Data Engineering - Learning Guide

This folder contains Jupyter notebooks that teach Matplotlib, the most popular Python library for data visualization. These notebooks are designed for data engineering freshers and can be completed in a single day.

## How to Use These Notebooks

1. **Complete Python basics first** - Make sure you've finished notebooks in "05 Python", "06 Python", and "07 Python" folders
2. **Complete NumPy and Pandas** - Understanding NumPy and Pandas will help you work with Matplotlib
3. **Open the notebooks** in Jupyter Notebook, JupyterLab, or VS Code with Jupyter extension
4. **Read the markdown cells** - they contain theory and explanations
5. **Run the code cells** - click on a cell and press `Shift + Enter` to execute
6. **Work through in order** - start with `01_matplotlib_introduction.ipynb` and progress sequentially
7. **Experiment** - try modifying the code to see what happens!

## Installation

Before starting, make sure Matplotlib and its dependencies are installed:

```bash
pip install matplotlib numpy pandas
```

## Notebook Guide

### 01_matplotlib_introduction.ipynb
- What is Matplotlib?
- Why Matplotlib for data engineering?
- Understanding the Matplotlib architecture (Figure, Axes, Plot)
- Basic plotting (line, bar, scatter, histogram)
- Working with Pandas DataFrames
- Customizing plots (labels, titles, colors, legends)
- Creating subplots
- Saving figures
- **Why it matters**: Matplotlib is the foundation for all data visualization in Python

### 02_advanced_plot_types.ipynb
- Box plots for understanding distributions and outliers
- Violin plots for detailed distribution visualization
- Heatmaps for correlation matrices and 2D data
- Pie charts for categorical proportions
- Area plots for cumulative data
- Stacked bar charts for multi-category comparisons
- **Why it matters**: Different plot types help you understand different aspects of your data

### 03_time_series_visualization.ipynb
- Creating time series plots with proper date formatting
- Handling datetime data from Pandas
- Multiple time series on one plot
- Resampling and aggregating time series data
- Customizing date axes
- Time series patterns and trends
- **Why it matters**: Time series data is everywhere in data engineering - pipeline metrics, data volumes, system performance

### 04_styling_and_themes.ipynb
- Built-in matplotlib styles
- Customizing colors and color palettes
- Font customization
- Figure aesthetics
- Creating professional-looking plots
- **Why it matters**: Professional styling makes your visualizations more credible and suitable for reports

### 05_object_oriented_approach.ipynb
- Understanding Figure and Axes objects
- OO approach vs pyplot
- Creating plots using OO interface
- Working with multiple axes
- When to use each approach
- **Why it matters**: OO approach gives you more control for complex plots and production code

### 06_data_quality_visualization.ipynb
- Visualizing missing data patterns
- Outlier detection and visualization
- Data distribution comparisons
- Before/after data cleaning visualization
- **Why it matters**: Data quality visualization is crucial for identifying issues before processing data

### 07_advanced_customization.ipynb
- Adding annotations and text
- Multiple y-axes
- Logarithmic scales
- Custom tick formatting
- Advanced legends
- **Why it matters**: Advanced customization helps create publication-quality visualizations

### 08_practical_example.ipynb
- Complete end-to-end data engineering visualization project
- ETL pipeline monitoring dashboard
- Combining multiple visualization types
- Real-world scenario
- **Why it matters**: Real-world projects combine all Matplotlib concepts

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

Matplotlib is essential for data engineering because:

- **Data Visualization** → Essential for exploring and understanding data
- **Reporting** → Create professional charts for reports and dashboards
- **Data Quality Checks** → Visualize data distributions, outliers, and patterns
- **ETL Monitoring** → Plot data pipeline metrics and performance
- **Integration** → Works directly with Pandas (which you already know!)
- **Industry Standard** → Most widely used plotting library in Python
- **Flexibility** → Can create publication-quality figures

## Learning Path for One Day

**Morning Session (3-4 hours):**
1. 01_matplotlib_introduction.ipynb (60 min)
2. 02_advanced_plot_types.ipynb (60 min)
3. 03_time_series_visualization.ipynb (60 min)
4. 04_styling_and_themes.ipynb (30 min)

**Afternoon Session (3-4 hours):**
5. 05_object_oriented_approach.ipynb (30 min)
6. 06_data_quality_visualization.ipynb (45 min)
7. 07_advanced_customization.ipynb (45 min)
8. 08_practical_example.ipynb (60 min)
9. 09_exercise.ipynb (60 min)
10. 10_exercise_solution.ipynb (30 min - review)

## Tips for Success

1. **Practice regularly** - Run the code cells and experiment with different values
2. **Understand the concepts** - Don't just copy code, understand why it works
3. **Connect to data engineering** - Think about how each visualization applies to data pipelines
4. **Review previous notebooks** - Concepts build on each other
5. **Ask questions** - If something doesn't make sense, review or ask for help
6. **Experiment** - Try modifying examples to see what happens
7. **Take notes** - Write down important concepts and common patterns
8. **Visualize your own data** - Apply what you learn to real data

## Common Matplotlib Operations Cheat Sheet

```python
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# Basic plot
plt.plot(x, y)
plt.xlabel('X Label')
plt.ylabel('Y Label')
plt.title('Title')
plt.show()

# Bar chart
plt.bar(categories, values)
plt.show()

# Scatter plot
plt.scatter(x, y)
plt.show()

# Histogram
plt.hist(data, bins=30)
plt.show()

# Subplots
fig, axes = plt.subplots(2, 2)
axes[0, 0].plot(x, y)

# Pandas integration
df.plot(x='col1', y='col2', kind='line')
df.plot(kind='bar')

# Styling
plt.style.use('ggplot')
plt.grid(True, alpha=0.3)
plt.legend()

# Saving
plt.savefig('plot.png', dpi=300, bbox_inches='tight')
```

## Plot Type Selection Guide

| Question | Plot Type |
|----------|-----------|
| How does a variable change over time? | Line plot |
| Compare categories? | Bar chart |
| Relationship between two variables? | Scatter plot |
| Distribution of data? | Histogram |
| Identify outliers? | Box plot |
| Correlation between variables? | Heatmap |
| Proportions/percentages? | Pie chart |
| Multiple time series? | Multiple line plots or stacked area |
| Data quality issues? | Box plots, histograms, missing data heatmaps |

## Next Steps

After completing these notebooks, you'll be ready to:
- Create professional visualizations for data engineering projects
- Monitor ETL pipelines with comprehensive dashboards
- Visualize data quality issues and patterns
- Create reports and presentations with publication-quality figures
- Integrate visualization into data engineering workflows
- Learn advanced visualization libraries (Seaborn, Plotly) if needed

Happy learning! 📊📈

