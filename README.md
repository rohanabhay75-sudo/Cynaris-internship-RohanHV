# TradeSight Export Analytics

Data Analyst Intern capstone project at Cynaris Solutions. This repository contains the Checkpoint 2 work: a repeatable data pipeline and baseline metrics for the B2B orders dataset.

## Objective

Build a repeatable pipeline that loads, validates and analyses order data, and calculate baseline business metrics that later checkpoints (currency impact, client profitability, compliance flags, BI dashboard) will build on.

## Datasets

| File | Rows | Description |
|---|---|---|
| `da_b2b_orders.csv` | 600 | B2B orders (Jan 2023 - Dec 2024): buyer, seller, category, quantity, price, payment terms, delivery days, returns |
| `da_product_catalogue.csv` | 50 | Product catalogue (MRP, COGS, stock, monthly sales) |
| `da_customer_profiles.csv` | 200 | Customer profiles (city, channel, orders, revenue, churn) |

The baseline metrics use the orders dataset. The catalogue and customer files do not share keys with orders, so they are profiled but not joined.

## Project structure

```
.
├── pipeline.ipynb           # Main pipeline (load, validate, calculate, export)
├── da_b2b_orders.csv
├── da_product_catalogue.csv
├── da_customer_profiles.csv
├── outputs/                 # Generated metric files
│   ├── baseline_metrics.csv
│   └── revenue_by_category.csv
├── README.md
└── .gitignore
```

## How to run

1. Install Python 3.11+ and the dependencies: `pip install pandas numpy jupyter`
2. Open `pipeline.ipynb` in VS Code or Jupyter.
3. Click **Restart**, then **Run All**. Results are written to the `outputs/` folder.

## Pipeline steps

1. **Load**: read the orders CSV and parse `order_date` as a date.
2. **Validate**: drop duplicate `order_id`s, check for nulls, and confirm `total_value_inr` equals `quantity_units x unit_price_inr`.
3. **Calculate**: compute baseline KPIs and group by category and month.
4. **Export**: save results as CSV files in `outputs/`.

## Baseline metrics

| Metric | Value |
|---|---|
| Total orders | 600 |
| Total revenue | INR 396.9 crore |
| Average order value | INR 66.1 lakh |
| On-time delivery rate | 77.5% |
| Average delivery time | 23.5 days |
| Return rate (units) | 1.01% |
| Repeat buyer rate | 37.8% |

## Key findings

- Revenue fell about 10.5% from 2023 (INR 209.5 cr) to 2024 (INR 187.4 cr).
- Top categories by revenue: IT Hardware, Industrial Machinery, Packaging. Lowest: Raw Materials.
- On-time delivery is highest for 60 Days Net terms (81.5%) and lowest for Advance (75.2%).

## Data quality notes

- No duplicate orders or null values; order values reconcile with quantity x unit price.
- `on_time_delivery` is almost uncorrelated with `delivery_days`, so its definition should be confirmed with the client.
- The orders file has no country or currency field, so the 12-country and FX analysis needs additional data.
- In the customer file, some rows have `Last_Purchase_Date` earlier than `First_Purchase_Date`.

## Tools

Python, pandas, Jupyter, VS Code, Git/GitHub
