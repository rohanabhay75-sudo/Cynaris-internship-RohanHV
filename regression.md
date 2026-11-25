# Week 4 – Day 3: Regression Analysis

## Objective

Measure relationships between variables using correlation and build a simple linear regression model to predict values.

## 1. Introduction

Regression analysis is a statistical technique used to understand relationships between variables and predict future outcomes.

**Real-world example:** Predicting employee salaries based on years of experience.

## 2. Dataset

Created a sample dataset containing:

| Experience | Salary |
| ---------- | -----: |
| 1          |  20000 |
| 2          |  25000 |
| 3          |  30000 |
| 4          |  40000 |
| 5          |  50000 |

- Independent Variable: Experience
- Dependent Variable: Salary

## 3. Correlation Analysis

Calculated Pearson and Spearman correlation coefficients.

- **Pearson Correlation:** Measures linear relationships between variables.
- **Spearman Correlation:** Measures monotonic relationships using ranked values.

## 4. Data Visualization

Created the following visualizations:

- Correlation Heatmap
- Scatter Plot
- Scatter Matrix

These visualizations help identify relationships between numerical variables.

## 5. Linear Regression Model

Built a Linear Regression model using Scikit-learn.

Steps performed:

1. Imported LinearRegression.
2. Selected independent and dependent variables.
3. Trained the model using `fit()`.
4. Predicted salary using `predict()`.

## 6. Model Evaluation

Evaluated the model using:

| Metric   | Description                                                    |
| -------- | -------------------------------------------------------------- |
| R² Score | Measures how well the model explains the data.                 |
| MAE      | Measures average absolute prediction error.                    |
| RMSE     | Measures prediction error with greater weight on large errors. |

## 7. Residual Analysis

Calculated residuals using:

`Residual = Actual Value - Predicted Value`

Created a residual plot to examine prediction errors and check model assumptions.

## 8. Real-World Applications

Regression analysis is used in:

- Sales forecasting
- Revenue prediction
- Salary estimation
- Customer behaviour analysis
- Business performance analysis

## 9. GitHub Activities

- Created `regression_analysis.ipynb`.
- Completed correlation analysis.
- Built a linear regression model.
- Evaluated model performance.
- Created visualizations.
- Committed and pushed the work to GitHub.

**Commit Message:**
`feat: correlation-regression week-4-day-3 complete`

## 10. Conclusion

Successfully learned correlation analysis and implemented a simple linear regression model using Python and Scikit-learn. Understood model evaluation metrics and residual analysis.

## Tools and Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- Scikit-learn
- Jupyter Notebook
- Git and GitHub

**Week 4 – Day 3: Completed**
