# Retail Performance & Inventory Analytics

An end-to-end retail analytics project built using Python, PostgreSQL, and Power BI to analyze sales performance, profitability, product performance, inventory levels, and stockout risk.

## Dashboard

### Retail Performance & Inventory Analytics

The Power BI report contains two pages focused on retail performance and inventory analysis.

### Page 1 — Retail Performance & Inventory Analytics

- Total Revenue
- Total Profit
- Units Sold
- Stockout Rate
- Monthly Revenue Trend
- Revenue vs Profit by Category
- Profit Margin by Category
- Top Products by Revenue

### Page 2 — Inventory & Risk Analysis

- Total Stock on Hand
- Stockout Rate
- Out-of-Stock Products
- Average Stock per Store
- Inventory by Product Category
- Top 10 Stores by Stockout Risk
- Top 10 Products by Stockout Risk
- Inventory Risk Detail

## Project Overview

This project brings sales and inventory data together to understand overall retail performance and identify areas of inventory risk.

The analysis covers:

- Sales and revenue performance
- Profit and profitability
- Product and category performance
- Store performance
- Inventory levels
- Out-of-stock products
- Stockout risk across stores and products
- Inventory coverage

## Key Insights

- Total revenue: **$14.44M**
- Total profit: **$4.01M**
- Units sold: **1.09M**
- Total stock on hand: **29.7K**
- Stockout rate: **4.83%**
- 20 distinct products experienced stockouts across at least one store

The analysis also identifies products and stores with higher stockout exposure, helping highlight areas that may require closer inventory attention.

## Tools & Technologies

- **Python** — Data cleaning and exploratory data analysis
- **Jupyter Notebook** — Data preparation and EDA
- **PostgreSQL** — SQL analysis
- **Power BI** — Data modeling, DAX measures, KPIs, and dashboard visualization

## Analysis

The SQL analysis includes:

- Revenue, units sold, and profit by product category
- Profit margin by category
- Product revenue ranking within categories
- Store-level revenue, profit, and stockout rate
- Products with the highest number of stockout stores
- Inventory coverage based on average monthly sales

The analysis uses joins between sales, products, stores, and inventory data to connect sales performance with inventory availability.

## Project Workflow

```text
Raw Data
    ↓
Data Cleaning & EDA
    ↓
Cleaned Datasets
    ↓
PostgreSQL / SQL Analysis
    ↓
Power BI Data Model
    ↓
DAX Measures & KPIs
    ↓
Interactive Dashboard
