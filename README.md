## Dataset Description

### Context

In the highly competitive digital retail landscape, understanding customer behavior, purchasing patterns, and sales performance is crucial for driving growth. This dataset contains 5,000 synthetic yet realistic retail transactions designed to mirror modern online marketplace dynamics — bridging customer demographics, product categorization, financial metrics, and operational logistics into a single, cohesive analytics asset.

### Content & Structure

* **File:** `ecommerce_sales_analytics_5000.csv`
* **Rows:** 5,000 unique orders
* **Columns:** 15 analytical fields
* **Scope:** Tracks the end-to-end lifecycle of a retail order — from purchase to shipment — enabling analysis ranging from basic data cleaning to advanced machine learning modeling.

---

### Key Feature Groups

| Category | Fields |
| :--- | :--- |
| **Demographics** | Customer Age, Gender, Location |
| **Product** | Product Category (and related identifiers) |
| **Financials** | Unit Price, Quantity, Discount %, Net Revenue |
| **Logistics** | Order Date, Shipping Date, Delivery Time Delta |

---

## Retail Sales Performance Summary

* **Revenue Overview:** Generated **$5.11M** in revenue across 5,000 orders, with an average order value (**AOV**) of **$1,022**.
* **Category Breakdown:** Electronics and Clothing are the top-performing categories, together driving over **70% of revenue**, with performance consistent across all four regions — indicating no single region is a dependency risk.
* **Payment Preferences:** Card payments lead, followed by Cash on Delivery, with Wallet as the smallest share.
* **Customer Satisfaction:** Customer satisfaction is a concern: average rating stands at **2.97 out of 5**, below the midpoint — this warrants further investigation into service quality, delivery performance, or product experience.
* **Trend Analysis:** Revenue trend data is currently under review to confirm accuracy before reporting seasonal patterns.

---

## Let's Dig Deeper

### SQL

#### Data Cleaning & Validation
Started with data cleaning & validation queries:
* Null checks across all columns
* Duplicate `order_id` check
* Revenue formula validation (`quantity * unit_price * (1 - discount)`)
* Outlier/invalid value checks (bad quantities, discounts, ratings, negative delivery days)

#### Core EDA Queries
Then moved to core EDA queries:
* Monthly revenue trend
* Revenue by product category
* Revenue by region
* Payment method behavior
* Discount impact on quantity and rating
* Delivery speed vs. customer rating
* Top customers by spend

#### Advanced SQL Queries
After that, we wrote advanced SQL queries:
* Running total of revenue using a window function
* Month-over-month revenue change using `LAG()`
* Customer ranking by region using `RANK()` with `PARTITION BY`
* Category share of total revenue using a window function

---

### Python

#### 1. Data Cleaning
*(Structure → Content → Stats, in that order)*
* **Missing values:** `isnull().sum()` $\rightarrow$ `fillna` (median for numeric, mode for categorical) or `dropna`
* **Data types:** Fix dates (`pd.to_datetime`), IDs as strings
* **Duplicates:** `duplicated()` $\rightarrow$ `drop_duplicates()`
* **Inconsistent text:** `.str.strip().str.title()` to fix casing/typos
* **Logical range checks:** Discount 0-1, rating 1-5, no negative quantities
* **Cross-field consistency:** Recompute $\text{revenue} = \text{qty} \times \text{price} \times (1 - \text{discount})$, flag mismatches
* **Outliers:** IQR method ($Q1 - 1.5 \times IQR$ to $Q3 + 1.5 \times IQR$)

#### 2. Feature Engineering
* Extract `order_month`, `order_weekday` from dates
* Derive `gross_revenue`, `discount_amount`
* Customer-level flags (new vs returning) via `groupby`

#### 3. EDA — One Plot Per Question
* **Univariate:** Histograms (distributions), countplots (categories)
* **Bivariate:** Barplots (revenue by category/region), scatterplots (discount vs revenue), boxplots (rating by delivery days)
* **Multivariate:** Correlation heatmap, pivot table heatmap (region $\times$ category)
* **Time-based:** Line plots for monthly/weekday trends

#### 4. Analytical Frameworks
* **RFM (Recency, Frequency, Monetary):** Identify best/at-risk customers
* **Cohort Analysis:** Retention by first-purchase month
* **Trend vs Seasonality:** Long-term direction vs repeating calendar patterns

---

### Tableau

* Built an **Executive Summary dashboard** with KPIs (Total Revenue, Avg Rating, Total Orders, AOV)
* Created visualizations: revenue trend, revenue by category & region, payment method breakdown
* Added interactive filters and cross-filtering actions
* Published dashboard to Tableau Public


