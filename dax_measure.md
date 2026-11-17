# Week 3 – Day 2: DAX Basics

## Project: Indian Business Dataset Analysis

### 1. Total Annual Revenue

```dax
Total Annual Revenue =
SUM(Businesses[Annual_Revenue_INR])
```

**Explanation:** Calculates the total annual revenue of all businesses.

### 2. Total Employees

```dax
Total Employees =
SUM(Businesses[Employees])
```

**Explanation:** Calculates the total number of employees across all businesses.

### 3. Total Businesses

```dax
Total Businesses =
DISTINCTCOUNT(Businesses[Business_ID])
```

**Explanation:** Counts the unique businesses in the dataset.

### 4. Average Customer Rating

```dax
Average Rating =
AVERAGE(Businesses[Customer_Rating])
```

**Explanation:** Calculates the average customer rating of businesses.

### 5. Karnataka Revenue using CALCULATE()

```dax
Karnataka Revenue =
CALCULATE(
    [Total Annual Revenue],
    Businesses[State] = "Karnataka"
)
```

**Explanation:** Calculates total annual revenue for businesses located in Karnataka by modifying the filter context.

## Key Learnings

- Understanding DAX fundamentals.
- Creating calculated measures.
- Using SUM(), AVERAGE() and DISTINCTCOUNT().
- Understanding CALCULATE().
- Learning Row Context and Filter Context.
- Creating interactive KPI cards.
- Analysing business revenue using Power BI.
