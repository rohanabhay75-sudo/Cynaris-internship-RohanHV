# Week 4 — Day 2: Probability

## 1. Objective

Understand probability concepts and key distributions used in data analysis and business forecasting.

## 2. Introduction

Probability is a mathematical concept used to measure the likelihood of an event occurring.

Probability values range from 0 to 1.

- 0 = Impossible event
- 0.5 = 50% chance
- 1 = Certain event

Probability helps businesses make informed decisions using data.

## 3. Tools and Technologies

- Python
- Jupyter Notebook
- NumPy
- Pandas
- Matplotlib
- SciPy

## 4. Practical Task 1: Basic Probability

### Definition

Basic probability measures the chance of an event happening.

### Formula

P(A) = Number of successful outcomes / Total outcomes

### Example

An e-commerce company has 10 customers. Six customers purchased products.

Probability of purchase:

P(A) = 6/10 = 0.6

**Result:** 60% probability of a customer purchasing a product.

## 5. Practical Task 2: Joint and Conditional Probability

### Contingency Table

A contingency table represents the relationship between two categorical variables.

Example:

| Gender | No Purchase | Purchase |
| ------ | ----------: | -------: |
| Male   |           2 |        3 |
| Female |           2 |        3 |
| Total  |           4 |        6 |

### Basic Probability

P(A) = 6/10 = 0.6

### Joint Probability

Joint probability measures the probability of two events happening together.

P(A ∩ B) = 3/10 = 0.3

### Conditional Probability

Conditional probability measures the probability of an event occurring given that another event has already occurred.

Formula:

P(A | B) = P(A ∩ B) / P(B)

Example:

P(Purchase | Male) = 3/5 = 0.6

**Result:** 60% of male customers purchased products.

## 6. Practical Task 3: Normal Distribution

### Definition

Normal distribution is a continuous probability distribution with a bell-shaped curve.

Most observations are concentrated around the mean.

### Python Implementation

```python
import numpy as np
import matplotlib.pyplot as plt

data = np.random.normal(loc=50, scale=10, size=1000)

print("Mean:", np.mean(data))
print("Standard Deviation:", np.std(data))

plt.hist(data, bins=30, density=True)
plt.title("Normal Distribution")
plt.xlabel("Values")
plt.ylabel("Density")
plt.show()
```

### 68-95-99.7 Rule

| Range                        | Percentage |
| ---------------------------- | ---------: |
| Mean ± 1 Standard Deviation  |        68% |
| Mean ± 2 Standard Deviations |        95% |
| Mean ± 3 Standard Deviations |      99.7% |

### Business Application

Normal distribution can help analyse employee salaries, customer spending and business performance when the data is approximately normally distributed.

## 7. Practical Task 4: Binomial Distribution

### Definition

Binomial distribution calculates the number of successful outcomes in a fixed number of independent trials.

### Python Implementation

```python
import numpy as np
import matplotlib.pyplot as plt

data = np.random.binomial(n=10, p=0.7, size=1000)

print("Average Success:", np.mean(data))

plt.hist(data, bins=np.arange(-0.5, 11.5, 1),
         edgecolor='black')

plt.title("Binomial Distribution")
plt.xlabel("Number of Successful Purchases")
plt.ylabel("Frequency")
plt.show()
```

### Parameters

- n = Number of trials (10)
- p = Probability of success (0.7)
- size = Number of simulations (1000)

**Result:** The expected average number of successful outcomes is approximately 7.

### Business Application

- Sales conversion prediction
- Marketing campaign analysis
- Customer purchase behaviour
- Transaction success analysis

## 8. Practical Task 5: Central Limit Theorem

### Definition

The Central Limit Theorem states that the distribution of sample means approaches a normal distribution when sufficiently large random samples are repeatedly selected from a population with finite variance.

### Python Implementation

```python
import numpy as np
import matplotlib.pyplot as plt

population = np.random.exponential(
    scale=500, size=10000
)

plt.hist(population, bins=50)
plt.title("Customer Spending Distribution")
plt.xlabel("Spending (₹)")
plt.ylabel("Frequency")
plt.show()

sample_means = []

for i in range(1000):
    sample = np.random.choice(population, size=50)
    sample_means.append(np.mean(sample))

print("Average of Sample Means:", np.mean(sample_means))

plt.hist(sample_means, bins=30, edgecolor='black')
plt.title("Central Limit Theorem")
plt.xlabel("Sample Means")
plt.ylabel("Frequency")
plt.show()
```

### Observation

- The original population follows a right-skewed distribution.
- The sample means form an approximately normal distribution.
- Larger sample sizes generally produce a better normal approximation.

### Business Application

- Sales forecasting
- Customer spending analysis
- Quality control
- Revenue estimation
- Business performance analysis

## 9. Viva Questions and Answers

### Q1. What is conditional probability?

Conditional probability is the probability of an event happening when another event has already occurred.

### Q2. What is the Central Limit Theorem?

The Central Limit Theorem states that the distribution of sample means approaches a normal distribution as the sample size becomes sufficiently large.

### Q3. What is the difference between discrete and continuous distributions?

| Discrete Distribution        | Continuous Distribution           |
| ---------------------------- | --------------------------------- |
| Has countable values         | Can take any value within a range |
| Example: Number of customers | Example: Customer spending        |
| Binomial distribution        | Normal distribution               |

## 10. Key Learnings

During this practical session, I learned:

1. Basic probability calculations.
2. Joint and conditional probability.
3. Normal distribution and its properties.
4. The 68-95-99.7 rule.
5. Binomial distribution using NumPy.
6. Central Limit Theorem through sampling simulation.
7. Practical applications of probability in business forecasting.

## 11. GitHub Tasks

Commands used to submit the completed work:

```bash
git add .
git commit -m "feat: probability-distributions week-4-day-2 complete"
git push origin feature/week-4-day-2
```

After pushing the changes, create a Pull Request and link the notebook in the PR description.

## 12. Conclusion

This practical session helped me understand probability and its applications in data analysis and business forecasting.

I implemented basic probability calculations, conditional probability, normal distribution, binomial distribution and the Central Limit Theorem using Python.

These concepts are useful for making data-driven business decisions and developing analytical skills.

---

**Week:** 4  
**Day:** 2  
**Topic:** Probability  
**Status:** Completed
