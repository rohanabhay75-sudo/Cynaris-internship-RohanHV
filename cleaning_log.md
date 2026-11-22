# Data Cleaning Log: Indian Business Dataset

**Week 2, Day 4: Data Cleaning**
**Date:** 2026-11-22
**Input:** `indian_business_raw.csv` (316 rows × 13 columns)
**Output:** `cleaned_dataset.csv` (300 rows × 13 columns)
**Tools:** Python, Pandas, NumPy

---

## 1. Before / After Data Quality Comparison

| Metric                                   | Before                                   | After                            |
| ---------------------------------------- | ---------------------------------------- | -------------------------------- |
| Rows                                     | 316                                      | 300                              |
| Duplicate Company_IDs                    | 16 (12 exact copies + 4 near-duplicates) | 0                                |
| Missing cells (total)                    | 155                                      | 0                                |
| Distinct City values                     | 85                                       | 16 (15 cities + "Unknown")       |
| Distinct Industry values                 | 59                                       | 11 (10 industries + "Unknown")   |
| Distinct State values                    | 44                                       | 11                               |
| Distinct Funding_Stage values            | 27                                       | 7 (6 stages + "Unknown")         |
| Distinct GST_Registered values           | 9                                        | 2 (Yes / No)                     |
| Revenue stored as text (e.g. "₹12.5 Cr") | 17                                       | 0                                |
| Registration_Date formats                | 4 mixed text formats                     | 1 (datetime)                     |
| Phone number formats                     | 5                                        | 1 (10 digits, or "Not Provided") |
| Impossible values                        | 14                                       | 0                                |

---

## 2. Cleaning Steps and Decisions

### Step 1: Load and detect missing values

- Loaded with `na_values=["N/A","NA","null","-"]` so that fake blanks become real `NaN`.
- Counted missing values with `df.isnull().sum()` before any change (155 missing cells).

### Step 2: Standardise text

- Applied `strip()`, lower-casing and a lookup against the list of valid values for City, Industry, State and Funding_Stage.
- Merged spelling variants and aliases (for example Bangalore / Bengalore → Bengaluru). The full mapping is in the Appendix.
- GST_Registered: `Y` and `1` → `Yes`; `N` and `0` → `No`.
- Company_Name: trimmed spaces, applied title case, and unified `Pvt Ltd` / `Pvt. Ltd.` / `Private Limited` / `PVT LTD` to `Pvt Ltd`.
- Cells corrected: City 162, Industry 122, State 101, Funding_Stage 139, GST_Registered 146, Company_Name 221.
- **Why:** the same city written four ways would be counted as four different cities in any group-by or chart.

### Step 3: Fix data types

- Annual_Revenue_Cr: removed `₹`, `Rs.`, `Cr` and commas, then `pd.to_numeric` (17 text values converted).
- Registration_Date: parsed each of the 4 formats with an explicit format string, treating dd/mm/yyyy as day-first (Indian convention).
- **Why explicit formats:** a generic `dayfirst=True` parse silently swaps day and month for ISO dates such as `2005-12-07`.

### Step 4: Remove duplicates

- Dropped repeated rows by `Company_ID` (316 → 300 rows, 16 removed).
- **Why Company_ID:** it is unique per company, and it also catches near-duplicates that differ only in name casing or spacing.

### Step 5: Impossible values set to missing

These are data-entry errors, not genuine outliers, so they were blanked before imputation.

| Column            | Rule                 | Values removed                   |
| ----------------- | -------------------- | -------------------------------- |
| Annual_Revenue_Cr | ≤ 0 or > 10,000 Cr   | 7 (2 negative, 5 absurdly large) |
| Employees         | < 1 or > 100,000     | 3                                |
| Profit_Margin_Pct | beyond ±100%         | 2                                |
| Founded_Year      | outside 1900 to 2026 | 2 (1850 and 2035)                |

### Step 6: Handle missing values

| Column            | Missing before       | Method                                  | Reason                                                                        |
| ----------------- | -------------------- | --------------------------------------- | ----------------------------------------------------------------------------- |
| Industry          | 6                    | `"Unknown"`                             | A mode would invent data                                                      |
| City              | 11                   | `"Unknown"`                             | Same reason                                                                   |
| Funding_Stage     | 12                   | `"Unknown"`                             | Same reason                                                                   |
| Annual_Revenue_Cr | 15 (21 after step 5) | Median = 36.32                          | Revenue is right-skewed, so the mean would be pulled up                       |
| Employees         | 16 (18 after step 5) | Median = 130                            | Same reason                                                                   |
| Profit_Margin_Pct | 34 (35 after step 5) | Median = 11.9                           | Robust to extreme values                                                      |
| Founded_Year      | 19 (21 after step 5) | Median = 1992                           | No related column to derive it from                                           |
| Registration_Date | 4                    | 1 January of the company's Founded_Year | Registration happens close to founding, so this is better than a blind median |
| Contact_Phone     | 38 (37 after dedupe) | `"Not Provided"`                        | A phone number cannot be guessed                                              |

Phone numbers were also reduced to their last 10 digits.

**Note:** "Before" counts are on the raw 316 rows (duplicates included). The bracketed counts are after removing duplicates and impossible values.

### Step 7: Outliers (IQR method)

Outliers are values outside `[Q1 − 1.5×IQR, Q3 + 1.5×IQR]`. They were **capped** at the fence rather than dropped.

| Column            | Q1    | Q3     | IQR    | Lower fence | Upper fence | Capped (low / high) |
| ----------------- | ----- | ------ | ------ | ----------- | ----------- | ------------------- |
| Annual_Revenue_Cr | 18.29 | 62.79  | 44.50  | −48.46      | 129.54      | 0 / 28              |
| Employees         | 63.00 | 236.75 | 173.75 | −197.62     | 497.38      | 0 / 26              |
| Profit_Margin_Pct | 8.00  | 16.55  | 8.55   | −4.83       | 29.38       | 4 / 6               |

- **Why cap instead of drop:** it keeps all 300 companies. Dropping rows would lose their other valid columns.
- **Why step 5 comes first:** the 5 absurdly large revenues would otherwise inflate Q3 and push the fence far too high.
- **Observation:** 28 revenues (about 9% of rows) were capped because company revenue is naturally right-skewed. For real analysis, a log transform or a manual review of those companies would be worth considering.

### Step 8: Save

- `cleaned_dataset.csv`: 300 rows, 13 columns, 0 missing values, 0 duplicates.
- Final types: Founded_Year and Employees are integers, Annual_Revenue_Cr and Profit_Margin_Pct are floats, and Registration_Date is a datetime.

---

## 3. Assumptions and Limitations

- Dates in `DD/MM/YYYY` format were read as day-first.
- 21 Founded_Year values, 18 Employees values and 21 Revenue values are imputed medians, not real data. Treat them with care in any analysis.
- Registration dates derived from Founded_Year are approximate (set to 1 January).
- `"Unknown"` and `"Not Provided"` were kept as visible labels, so they can be filtered out later.

---

## 4. CIA Session (fill in)

- **Query 1:** "What is the best strategy for handling missing values in a time-series dataset?"
  - Key insights: _(add your notes here)_
- **Query 2:** "What are the most common data quality issues analysts encounter in production datasets?"
  - Key insights: _(add your notes here)_
- **Career tab search ("Data Cleaning"):** _(roles and skills you found)_

---

## Appendix: Standardisation Mappings

All values were also corrected for upper/lower case and extra spaces.

**City**

- Bengaluru ← Bangalore, Bengalore
- Mumbai ← Bombay, Mumbay
- Chennai ← Madras, Chenai
- Hyderabad ← Hyderbad, Hydrabad
- Pune ← Poona
- Delhi ← New Delhi, Dehli
- Kolkata ← Calcutta, Kolkatta
- Ahmedabad ← Ahmadabad, Ahmedbad
- Jaipur ← Jaipure
- Kochi ← Cochin, Kochin
- Coimbatore ← Coimbatur, Kovai
- Mysuru ← Mysore, Mysoore
- Surat ← Surath
- Lucknow ← Lukhnow
- Indore ← Indor

**Industry**

- IT Services ← IT Service, I.T. Services
- Textiles ← Textile, Textilez
- Manufacturing ← Manufactring, Mfg
- Retail ← Retial
- Pharma ← Pharmaceuticals, Pharmaa
- Agriculture ← Agricultur, Agri
- Logistics ← Logistic, Logisitcs
- Food Processing ← Food Procesing
- Real Estate ← Realestate
- Education ← Educaton

**State**

- Tamil Nadu ← Tamilnadu
- West Bengal ← Westbengal
- Uttar Pradesh ← Uttarpradesh
- Madhya Pradesh ← Madhyapradesh

**GST_Registered:** `Y`, `1` → Yes; `N`, `0` → No
