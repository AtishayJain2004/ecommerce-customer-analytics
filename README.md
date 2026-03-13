# E-Commerce Customer Analytics

## Project Overview

This project analyzes an e-commerce dataset to understand **sales performance, product trends, and customer behavior**.
Using **SQL Server for data analysis** and **Power BI for visualization**, the project explores key business metrics and applies **RFM (Recency, Frequency, Monetary) analysis** to segment customers.

The goal is to transform raw transactional data into **actionable insights that help businesses understand customer value and product performance.**

---

## Tools & Technologies

* **SQL Server (SSMS)** – Data cleaning, transformation, and analysis
* **Power BI** – Interactive dashboard and data visualization
* **CSV Dataset** – Raw e-commerce transactional data

---

## Dataset

The project uses the **Olist Brazilian E-Commerce Dataset**, which contains information about:

* Customers
* Orders
* Order Items
* Payments
* Reviews
* Products
* Sellers
* Geolocation

Due to **GitHub file size limitations**, the raw dataset is not included in this repository.

You can download it here:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## Project Structure

```
ecommerce-customer-analytics
│
├── dashboard_images        # Dashboard screenshots for preview
│
├── powerbi                 # Power BI dashboard file (.pbix)
│
├── schema                  # Database schema / ER diagram
│
├── sql                     # SQL queries used for analysis
│
└── README.md
```

---

## Data Preparation

The CSV files were imported into **SQL Server**, where they were structured into relational tables.
Primary and foreign key relationships were established to build a structured data model.

Data transformations included:

* Joining multiple tables
* Aggregating order data
* Creating customer-level metrics
* Preparing data for customer segmentation

---

## Customer Segmentation (RFM Analysis)

Customers were segmented using the **RFM Model**:

**Recency** – How recently a customer made a purchase
**Frequency** – How often the customer makes purchases
**Monetary** – Total amount spent by the customer

Customers were categorized into segments such as:

* **Champions** – Highly valuable and recent customers
* **Loyal Customers** – Frequent buyers
* **Others** – Lower engagement customers

This segmentation helps businesses identify **high-value customers and retention opportunities.**

---

## Dashboard Pages

### Sales Overview

Displays overall business performance including revenue, total orders, average order value, and sales trends over time.

![Sales Overview](dashboard_images/sales_overview.png)

---

### Product Insights

Analyzes product performance and highlights the **top-performing product categories and products by revenue**.

![Product Insights](dashboard_images/product_insights.png)

---

### Customer Segmentation

Visualizes **customer segments using RFM analysis** and shows revenue contribution by customer type.

![Customer Segmentation](dashboard_images/customer_segmentation.png)

---

## Key Insights

* Total Revenue: **$13.22M**
* Total Orders: **96K**
* Average Order Value: **137**
* Majority of customers fall into the **"Others" segment**, indicating potential opportunities for improving customer retention.
* Certain product categories generate significantly higher revenue, highlighting **high-performing product lines.**

---

## Future Improvements

Possible enhancements for this project include:

* Customer lifetime value (CLV) analysis
* Sales forecasting
* Geographic sales analysis
* Marketing campaign effectiveness analysis

---

## Author

**Atishay Jain**
