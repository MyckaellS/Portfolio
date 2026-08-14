# Olist Revenue Analysis

## Executive Summary

Olist is a Brazilian E-Commerce platform that connects wholesalers and individual retailers to customers golabally. I was tasked with targetting products, plans, and how to assign upcoming resources.

### Executive Questions:
- What are our best products?
- How do we allocate our resources?

### Insights:
  - Health and Beauty is currently the top performing category currently. Allocating resources to increase the volume of these products could drive strong short term returns. The Warehousing and Finance team should plan accordingly.
  - The Gifts category is currently the second top category, however, it is forecasted to soon become the top selling category by 2018 (next year). The Product team should expand or reinforce our current selection to promote further growth.
  - Most electronics are not expected to generate significant revenue in the future. Accessories account for the majority of revenue within this category. The Product and Finance team should consider discontinuing or changing sales plans.
  - Most transactions fall below the average value. The Marketing team can implement promotions such as buy-one-get-one (BOGO) offers. This can help drive average order value, encourage repeat purchases, and retain our current customers.

---

## Dashboard

<img width="1595" height="895" alt="Screenshot 2026-04-04 123154" src="https://github.com/user-attachments/assets/f4bc73a7-dc36-42ef-a709-c6119b973d2a" />

This dashboard can be accessed on Tabluea Public
<a href="https://public.tableau.com/app/profile/myckaell.silva5351/viz/OlistSalesOverview/OlistSalesOverview"> here. </a>


## Worksheets

### Worksheet 1: Sales by Month

<img width="400" height="200" alt="Screenshot 2026-04-04 122944" src="https://github.com/user-attachments/assets/cbe21b11-be17-4b27-8210-53495c02b348" />

The first visualization provides an overview of revenue over time, enabling a view of broader trends across product categories, sellers, and time.


### Worksheet 2: Sales by Category

<img width="400" height="420" alt="Screenshot 2026-04-04 123007" src="https://github.com/user-attachments/assets/b8628844-f9fd-420c-931c-c8a25f07970a" />

The second visualization ranks product categories, providing insight into the relative performance of each category.

### Worksheet 3: Sales by Zip

<img width="400" height="250" alt="Screenshot 2026-04-04 122845" src="https://github.com/user-attachments/assets/fb9f2cf3-0a3a-4af4-8694-03a8dc32a479" />

The third visualization shows sales by location, allowing for the identification of key markets. This creates a channel for understanding how geographic distribution may influence delivery logistics and product preferences.


### Worksheet 4: Sales by Seller

<img width="400" height="420" alt="Screenshot 2026-04-04 122926" src="https://github.com/user-attachments/assets/6e802c22-41e9-4905-bf0b-0c1d0b498d4e" />

The fourth visualization ranks sellers, providing insight into the relative performance of each seller.


### KPIs

<img width="500" height="84" alt="Screenshot 2026-04-04 123052" src="https://github.com/user-attachments/assets/d717f73b-457a-43b9-b461-888efdf34594" />

The KPIs displayed include total sales and total orders. They serve as key reference points for quick calculations and decision making.


### Filters

<img width="500" height="85" alt="Screenshot 2026-04-04 123121" src="https://github.com/user-attachments/assets/a65cc408-ac60-42d3-aecb-74334b8a7431" />

The dashboard is fully interactive through the use of filters, allowing users to refine views by year, month, and category. Additionally, seller specific filtering can be applied by selecting a corresponding column within the “Sales by Seller” worksheet.

---

## Entity Relationship Diagram

<img width="3000" height="2164" alt="db-schema" src="https://github.com/user-attachments/assets/341653f7-9ad9-435a-b2e2-d53040065cb7" />

### Queries

### Query 1: Past Revenue

This statement returns product categories based on their generated revenue. It also includes supporting information to help visualize the distribution of sales.

### Query 2: Growth Rate

This statement uses multiple CTE's to expand upon aggregated data. The CTE's calculate the growth rate, which can then be projected to estimate potential gains.

### Query 3: Sales Forecast

This group of CTE's is designed to forecast future sales for each category using a linear regression. It includes three columns projecting cumulative revenue over 1, 5, and 10 years.
