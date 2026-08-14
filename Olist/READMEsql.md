# Olist Exploratory Analysis

## Objective

The Olist Exploratory Analysis project aimed to identify patterns and outliers in the data. The primary focus was on uncovering relationships between sales, product categories, sellers, and time. This experience was designed to push my limits in SQL. This data set is from <a href="https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training"> Kaggle. </a>

### Skills Learned

- Using CTEs to perform queries on aggregate functions.
- Turning the data into a story or reasoning.
- Performing more complex queries, such as a linear regression.

### Entity Relationship Diagram

<img width="3000" height="2164" alt="db-schema" src="https://github.com/user-attachments/assets/341653f7-9ad9-435a-b2e2-d53040065cb7" />

## Queries

### Query 1: Past Revenue

This statement returns product categories based on their generated revenue. It also includes supporting information to help visualize the distribution of sales.

### Query 2: Growth Rate

This statement uses multiple CTE's to expand upon aggregated data. The CTE's calculate the growth rate, which can then be projected to estimate potential gains.

### Query 3: Lin Reg Sales Forecast

This group of CTE's is designed to forecast future sales for each category using a linear regression. It includes three columns projecting cumulative revenue over 1, 5, and 10 years.

### Recommendations and Insights
  - Health and Beauty is currently the top performing category. Increasing the volume of these products could drive strong short term returns.
  - Although the Presents category is not far behind in current sales, it is projected to become the top selling category. Expanding the supplier base to increase product variety could help maximize future revenue.
  - Most electronics are not expected to generate significant revenue in the future. Accessories account for the majority of revenue within this category.
  - Most transactions fall below the average value. Implementing promotions such as buy-one-get-one (BOGO) offers may help increase purchase volume and encourage repeat purchases.
