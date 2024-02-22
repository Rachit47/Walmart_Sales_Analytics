# Walmart Sales Data Analysis

## Introduction

The objective of this project is to delve into Walmart Sales data, aiming to discern the top-performing branches and products, analyze the sales trends across various product categories, and understand customer behavior. The primary goal is to investigate opportunities for enhancing and optimizing sales strategies. The dataset utilized for this analysis was sourced from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

## Objective

The primary objective of this project is to acquire insights into Walmart's sales data, aiming to comprehend the various factors influencing the sales performance across its branches.

## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                 | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

### Types of Analysis

1. Product Analysis

> Perform an in-depth analysis of the data to gain insights into various product lines, identifying top-performing ones and areas for enhancement.

2. Sales Analysis

> The objective of this analysis is to discern sales trends for products. The findings will enable us to evaluate the efficacy of each sales strategy employed by the business and determine necessary adjustments to enhance sales.

3. Customer Analysis

> This analysis seeks to unveil distinct customer segments, purchasing patterns, and the profitability associated with each segment.

## Methodology

1. **Data Wrangling:** The initial stage involves examining the data to identify and handle NULL and missing values using appropriate replacement methods.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This step entails creating new columns derived from existing ones to provide additional insights.

> A. Introduce a column named time_of_day to categorize sales into Morning, Afternoon, and Evening periods, facilitating analysis of peak sales times.

> B. Incorporate a column named day_name to record the day of the week for each transaction (Mon, Tue, Wed, Thur, Fri), aiding in identifying the busiest days for each branch.

> C. Integrate a column named month_name to indicate the month of each transaction (Jan, Feb, Mar), assisting in determining the most profitable months of the year.

3. **Exploratory Data Analysis (EDA):** This phase involves investigating the data to address the project's objectives and questions.

## Business Inquiries to Address

### General Inquiries

1. How many distinct cities are represented in the dataset?
2. Which city corresponds to each branch?

### Product Analysis

1. How many distinct product lines are included in the dataset?
2. What is the predominant payment method?
3. Which product line sells the most units?
4. What is the total revenue generated each month?
5. Which month recorded the highest Cost of Goods Sold (COGS)?
6. Which product line generated the highest revenue?
7. Which city generated the highest revenue?
8. Which product line incurred the highest VAT (Value Added Tax)?
9. Retrieve each product line and append a column indicating "Good" or "Bad" based on whether its sales exceed the average.
10. Which branch exceeded the average number of products sold?
11. What is the most prevalent product line based on gender?
12. What is the average rating for each product line?

### Sales Insights

1. Count of sales transactions per time of day, categorized by weekday.
2. Which customer type contributes the most to revenue?
3. Which city has the highest percentage of tax or VAT (Value Added Tax)?
4. Which customer type contributes the most to VAT payments?

### Customer Profiling

1. How many distinct customer types are represented in the dataset?
2. How many distinct payment methods are used by customers?
3. What is the most common customer type?
4. Which customer type makes the highest number of purchases?
5. What is the predominant gender among customers?
6. How is gender distributed across branches?
7. During which time of day do customers provide the highest ratings?
8. During which time of day, per branch, do customers provide the highest ratings?
9. Which day of the week receives the highest average ratings?
10. Which day of the week, per branch, receives the highest average ratings?


## Revenue And Profit Calculations

$ COGS = unitsPrice * quantity $

$ VAT = 5\% * COGS $

$VAT$ is added to the $COGS$ and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

**Gross Margin** is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

<u>**Example with the first row in our DB:**</u>

**Data given:**

- $ \text{Unite Price} = 45.79 $
- $ \text{Quantity} = 7 $

$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5\% * COGS\\= 5\%  320.53 = 16.0265 $

$ total = VAT + COGS\\= 16.0265 + 320.53 = $336.5565$

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\\=\frac{16.0265}{336.5565} = 0.047619\\\approx 4.7619\% $
