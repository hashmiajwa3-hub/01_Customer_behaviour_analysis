# Consumer Shopping Behaviour Analysis

**A retail analytics case study identifying which customer segments, channels, and purchase drivers actually generate revenue — and where the business is leaving loyalty on the table.**

## The Business Question

A retail company wanted to understand its customers' shopping behaviour to improve sales, satisfaction, and long-term loyalty. Management had noticed shifting purchase patterns across demographics, categories, and channels, but couldn't say *why* — or which levers (discounts, reviews, seasonality, payment method) actually drove repeat business.

This analysis answers: **how can the company use its own shopping data to identify trends, improve engagement, and sharpen its marketing and product strategy?**

## Headline Findings

Based on 3,900 customer transactions:

| Finding | Detail |
|---|---|
| Revenue concentration | Male customers are 68% of the base but generate 67.7% of revenue ($157,890); female customers convert at a *higher* average spend ($60.25 vs $59.54) despite being the smaller group |
| Category leader | Clothing drives 44.7% of revenue ($104,264); Outerwear has the weakest average spend, $3 below the overall average |
| Best season | Fall is the strongest ($60,018 revenue, $61.56 avg spend); Summer is the weakest — but the gap is modest, suggesting steady year-round demand rather than sharp seasonal peaks |
| Hidden segment value | Young Adults (18–25) are the *smallest* customer segment (571 people) but spend the *most* per transaction ($60.65 avg) — an under-leveraged growth segment |
| Loyalty signal | Seniors have the lowest average spend but the highest repeat-purchase history (26.19 previous purchases on average) — the most loyal, least monetized segment |

## Business Recommendations

- **Double down on Clothing and top SKUs** (Dress, Shirt, Blouse) — they carry both revenue share and above-average spend
- **Target Young Adults with acquisition offers** — small segment today, but the highest per-transaction value signals room to grow spend, not just headcount
- **Design a loyalty/retention play for Seniors** — high repeat-purchase history at lower spend suggests an upsell opportunity, not a lost cause
- **Treat seasonality as secondary** — with revenue fairly balanced across seasons, marketing spend is better allocated toward segment and channel targeting than seasonal campaigns

## What's Inside

| File | What it is |
|---|---|
| `01_data/` | Raw and cleaned transaction data, plus the original business problem statement |
| `02_scripts_python/` | Data cleaning and exploratory analysis notebooks |
| `03_sql_queries/` | SQL used to model and query the transaction data |
| `04_dashboard/` | Power BI dashboard (KPI overview, trends, segment views) |
| `05_reports/` | Full written business report and executive presentation deck |

## Tools used
Python (Pandas/NumPy) for data cleaning, SQL (MySQL) for analysis, Power BI for visualization, Git/GitHub for version control.
