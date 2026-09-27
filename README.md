# 📊 Exploratory Data Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing **customer, order, product, and shop data using SQL**.

The objective is to understand sales performance, customer purchasing behavior, product demand, shop performance, revenue distribution, and other important business patterns.

The database consists of four main tables:

* `customers`
* `orders`
* `products`
* `shops`

SQL queries were used to answer business-related questions and generate meaningful insights from the available data.

---

## 🎯 Project Objectives

* Analyze customer purchasing behavior and spending
* Identify high-performing customers, products, and shops
* Analyze revenue and sales patterns
* Identify products that have never been ordered
* Understand customer loyalty and ordering behavior
* Compare shop performance across locations and shop categories
* Generate a detailed customer summary for business analysis

---

## 🗂️ Database Tables

| Table       | Description                                      |
| ----------- | ------------------------------------------------ |
| `customers` | Customer information and loyalty details         |
| `orders`    | Order transactions and order-related information |
| `products`  | Product information and categories               |
| `shops`     | Shop information, locations, and shop types      |

---

## 🔍 Exploratory Data Analysis

The project answers **23 business questions** using SQL:

1. Top 3 Highest Spending Customers
2. Best-Selling Product in Each Category
3. Customers Who Never Placed an Order
4. Month-over-Month Revenue Growth for 2024
5. Percentage of Cancelled or Returned Orders by Shop
6. Customers Ordering from Multiple Shops
7. Second Highest Order Amount for Each Customer
8. Running Total Revenue per Shop
9. Products That Have Never Been Ordered
10. Average Order Value by Loyalty Tier
11. Time Taken by Customers to Place Their First Order
12. Classification of Orders by Value
13. Top-Performing Shop in Each State
14. Customers Spending Above the Average
15. Highest and Lowest Performing Shops by Shop Type
16. Customers Placing Multiple Orders on the Same Date
17. Three-Month Moving Average of Orders
18. Revenue Contribution by Product Category
19. Customers Who Purchased from Every Category
20. Busiest Day of the Week for Each Shop
21. Longest Gap Between Customer Orders
22. Overall and State-Level Revenue Ranking of Shops
23. Complete Customer Summary Report

---

## 🛠️ SQL Analysis Areas

The analysis covers:

* Customer spending analysis
* Product performance
* Shop performance
* Revenue analysis
* Order status analysis
* Customer loyalty analysis
* Product category analysis
* State-level shop comparison
* Customer ordering frequency
* Revenue ranking
* Moving averages
* Running totals
* Customer purchase gaps
* Detailed customer summary

---

## 📈 Key Findings

### 💰 Revenue & Orders

* Total revenue generated was approximately **₹6.78 Crore** across **800 orders**.
* Delivered orders contributed approximately **₹4.21 Crore**, representing around **62%** of total revenue.
* Nearly **17% of orders were Cancelled or Returned**.

### 🏪 Shop Performance

The analysis identified differences in shop performance across locations and shop types.

Three shops had particularly high cancelled/returned order percentages:

* Nagpur Plaza — **30.4%**
* Lucknow Central — **29.1%**
* Kochi Square — **21.9%**

**Online Hub** generated approximately **₹2.82 Crore** from **333 orders**, while Pop-up Stores generated approximately **₹38.6 Lakh**.

### 🛍️ Product & Category Performance

The major revenue-generating categories were:

* Beauty — **22.3%**
* Electronics — **21.9%**
* Fashion — **19.8%**

Together, these categories contributed close to two-thirds of total sales.

Sports contributed approximately **3.4%**, while Home & Kitchen contributed approximately **5%**.

The analysis also identified **Nivea Face Wash** and **Nike Running Shoes** as the best-selling products, with **80 units each**.

### 👥 Customer Analysis

* Curtis Smith was the highest-spending customer at approximately **₹10.48 Lakh**.
* David Allen followed with approximately **₹10.21 Lakh**.
* **100 out of 120 customers (83%)** purchased from more than three different outlets.
* No customer purchased products from all eight categories.
* Some customers had gaps of more than **900 days** between orders.
* Gold-tier customers had the highest average order value at approximately **₹95,532**.
* Platinum customers followed with approximately **₹94,064**.

---

## 💡 Business Insights

The SQL analysis provides insights into:

* High-value customers
* Best-performing products
* Revenue-generating categories
* Inactive customers
* Shop-level performance
* Cancellation and return patterns
* Customer loyalty and spending behavior
* Product demand
* Customer ordering frequency
* Revenue distribution across shops and categories

These insights can support business analysis by identifying strong-performing areas as well as customers, products, or shops that may require additional attention.

---

## 📁 Project Structure

```text
Exploratory-Data-Analysis-SQL/
│
├── README.md
│
├── SQL/
│   └── EDA_Analysis.sql
│
├── Data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── products.csv
│   └── shops.csv
│
├── Report/
│   └── SQL_EDA_Report.pdf
│
└── Screenshots/
    └── analysis_outputs.png
```

---

## 🚀 Project Workflow

```text
Raw Data
   ↓
Database Tables
   ↓
SQL Data Exploration
   ↓
Business Questions
   ↓
SQL Analysis
   ↓
Customer / Product / Shop Analysis
   ↓
Revenue & Sales Analysis
   ↓
Business Insights
```

---

## 📌 Conclusion

This project demonstrates how **SQL can be used to transform transactional business data into meaningful insights**.


The analysis covers customer behavior, product demand, shop performance, revenue distribution, order patterns, and loyalty behavior. It also demonstrates how SQL-based analysis can help identify areas of strong performance and areas requiring further attention.
