-- =============================================
-- CONSUMER BEHAVIOUR ANALYSIS
-- Database : customers_behaviour
-- Table    : customers
-- =============================================

USE customers_behaviour;

-- =============================================
-- CATEGORY 1: REVENUE & SALES PERFORMANCE
-- =============================================

-- Q1. Total revenue and average purchase amount by gender
SELECT 
    gender,
    COUNT(customer_id)            AS total_customers,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY gender
ORDER BY total_revenue DESC;

-- Q2. Total revenue by product category
SELECT 
    category,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY category
ORDER BY total_revenue DESC;

-- Q3. Total revenue by season
SELECT 
    season,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY season
ORDER BY total_revenue DESC;

-- Q4. Revenue contribution by age group
SELECT 
    age_group,
    COUNT(customer_id)            AS total_customers,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY age_group
ORDER BY total_revenue DESC;

-- Q5. Top 10 products by total revenue
SELECT 
    item_purchased,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY item_purchased
ORDER BY total_revenue DESC
LIMIT 10;

-- Q6. Average purchase amount by channel (Online vs Offline)
SELECT 
    CASE 
        WHEN shipping_type = 'Store Pickup' THEN 'Offline'
        ELSE 'Online'
    END                           AS channel,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY channel
ORDER BY total_revenue DESC;

-- =============================================
-- CATEGORY 2: CUSTOMER SEGMENTATION
-- =============================================

-- Q7. Customer count and avg spend per age group
SELECT 
    age_group,
    COUNT(customer_id)            AS total_customers,
    ROUND(AVG(purchase_amount),2) AS avg_spend,
    ROUND(AVG(previous_purchases),2) AS avg_previous_purchases
FROM customers
GROUP BY age_group
ORDER BY avg_spend DESC;

-- Q8. Gender distribution across each product category
SELECT 
    category,
    gender,
    COUNT(customer_id)            AS total_customers,
    ROUND(100.0 * COUNT(customer_id) / 
        SUM(COUNT(customer_id)) OVER (PARTITION BY category), 2) AS pct_share
FROM customers
GROUP BY category, gender
ORDER BY category, total_customers DESC;

-- Q9. Top 10 locations by total revenue
SELECT 
    location,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 10;

-- Q10. Average purchase amount per age group per season
SELECT 
    age_group,
    season,
    COUNT(customer_id)            AS total_orders,
    ROUND(AVG(purchase_amount),2) AS avg_purchase
FROM customers
GROUP BY age_group, season
ORDER BY age_group, avg_purchase DESC;

-- =============================================
-- CATEGORY 3: DISCOUNT & PROMOTION
-- =============================================

-- Q11. Avg spend — discounted vs non-discounted customers
SELECT 
    discount_applied,
    COUNT(customer_id)            AS total_customers,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY discount_applied
ORDER BY avg_spend DESC;

-- Q12. Products with highest discount application rate
SELECT 
    item_purchased,
    COUNT(customer_id)            AS total_orders,
    SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) AS discounted_orders,
    ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(customer_id), 2)  AS discount_rate_pct
FROM customers
GROUP BY item_purchased
ORDER BY discount_rate_pct DESC
LIMIT 10;

-- Q13. Avg previous purchases — discounted vs non-discounted
SELECT 
    discount_applied,
    ROUND(AVG(previous_purchases),2) AS avg_previous_purchases,
    ROUND(AVG(purchase_amount),2)    AS avg_spend
FROM customers
GROUP BY discount_applied;

-- Q14. Discount rate and avg spend by age group
SELECT 
    age_group,
    COUNT(customer_id)            AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(customer_id), 2)  AS discount_rate_pct,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY age_group
ORDER BY discount_rate_pct DESC;

-- =============================================
-- CATEGORY 4: LOYALTY & RETENTION
-- =============================================

-- Q15. Customer segments — New, Returning, Loyal
SELECT 
    CASE 
        WHEN previous_purchases BETWEEN 1  AND 10 THEN 'New'
        WHEN previous_purchases BETWEEN 11 AND 25 THEN 'Returning'
        ELSE 'Loyal'
    END                           AS customer_segment,
    COUNT(customer_id)            AS total_customers,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- Q16. Subscribed vs non-subscribed — avg purchase frequency days
SELECT 
    subscription_status,
    COUNT(customer_id)                       AS total_customers,
    ROUND(AVG(purchase_frequency_days),2)    AS avg_frequency_days,
    ROUND(AVG(purchase_amount),2)            AS avg_spend
FROM customers
GROUP BY subscription_status
ORDER BY avg_frequency_days;

-- Q17. Avg previous purchases — subscribed vs non-subscribed
SELECT 
    subscription_status,
    ROUND(AVG(previous_purchases),2)  AS avg_previous_purchases,
    ROUND(AVG(purchase_amount),2)     AS avg_spend,
    COUNT(customer_id)                AS total_customers
FROM customers
GROUP BY subscription_status;

-- Q18. Total revenue by purchase frequency segment
SELECT 
    frequency_of_purchases,
    COUNT(customer_id)            AS total_customers,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY frequency_of_purchases
ORDER BY total_revenue DESC;

-- Q19. Repeat buyers (previous purchases > 25) by subscription status
SELECT 
    subscription_status,
    COUNT(customer_id)            AS repeat_buyers,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
WHERE previous_purchases > 25
GROUP BY subscription_status
ORDER BY repeat_buyers DESC;

-- =============================================
-- CATEGORY 5: PAYMENT & SHIPPING
-- =============================================

-- Q20. Revenue and avg spend by payment method
SELECT 
    payment_method,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q21. Payment method preference — subscribed vs non-subscribed
SELECT 
    subscription_status,
    payment_method,
    COUNT(customer_id)            AS total_customers,
    ROUND(100.0 * COUNT(customer_id) /
        SUM(COUNT(customer_id)) OVER (PARTITION BY subscription_status), 2) AS pct_share
FROM customers
GROUP BY subscription_status, payment_method
ORDER BY subscription_status, total_customers DESC;

-- Q22. Revenue and order count by shipping type
SELECT 
    shipping_type,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY shipping_type
ORDER BY total_revenue DESC;

-- Q23. Most popular shipping type per category
SELECT 
    category,
    shipping_type,
    COUNT(customer_id)            AS total_orders
FROM customers
GROUP BY category, shipping_type
ORDER BY category, total_orders DESC;

-- =============================================
-- CATEGORY 6: PRODUCT & REVIEW PERFORMANCE
-- =============================================

-- Q24. Top 5 products by average review rating
SELECT 
    item_purchased,
    COUNT(customer_id)               AS total_orders,
    ROUND(AVG(review_rating),2)      AS avg_rating,
    ROUND(AVG(purchase_amount),2)    AS avg_spend
FROM customers
GROUP BY item_purchased
ORDER BY avg_rating DESC
LIMIT 5;

-- Q25. Avg spend by review rating band
SELECT 
    CASE 
        WHEN review_rating BETWEEN 1.0 AND 2.0 THEN '1.0 - 2.0 (Poor)'
        WHEN review_rating BETWEEN 2.1 AND 3.0 THEN '2.1 - 3.0 (Below Avg)'
        WHEN review_rating BETWEEN 3.1 AND 4.0 THEN '3.1 - 4.0 (Average)'
        WHEN review_rating BETWEEN 4.1 AND 5.0 THEN '4.1 - 5.0 (Excellent)'
    END                              AS rating_band,
    COUNT(customer_id)               AS total_orders,
    ROUND(AVG(purchase_amount),2)    AS avg_spend
FROM customers
GROUP BY rating_band
ORDER BY avg_spend DESC;

-- Q26. Average review rating by category
SELECT 
    category,
    COUNT(customer_id)            AS total_orders,
    ROUND(AVG(review_rating),2)   AS avg_rating
FROM customers
GROUP BY category
ORDER BY avg_rating DESC;

-- Q27. Avg review rating — discounted vs non-discounted
SELECT 
    discount_applied,
    COUNT(customer_id)            AS total_orders,
    ROUND(AVG(review_rating),2)   AS avg_rating,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY discount_applied;

-- =============================================
-- CATEGORY 7: SEASONAL & CHANNEL TRENDS
-- =============================================

-- Q28. Best performing category per season
SELECT 
    season,
    category,
    SUM(purchase_amount)          AS total_revenue,
    COUNT(customer_id)            AS total_orders
FROM customers
GROUP BY season, category
ORDER BY season, total_revenue DESC;

-- Q29. Online vs Offline revenue split by season
SELECT 
    season,
    CASE 
        WHEN shipping_type = 'Store Pickup' THEN 'Offline'
        ELSE 'Online'
    END                           AS channel,
    COUNT(customer_id)            AS total_orders,
    SUM(purchase_amount)          AS total_revenue,
    ROUND(AVG(purchase_amount),2) AS avg_spend
FROM customers
GROUP BY season, channel
ORDER BY season, total_revenue DESC;

-- Q30. Age group by channel preference
SELECT 
    age_group,
    CASE 
        WHEN shipping_type = 'Store Pickup' THEN 'Offline'
        ELSE 'Online'
    END                           AS channel,
    COUNT(customer_id)            AS total_customers,
    ROUND(100.0 * COUNT(customer_id) /
        SUM(COUNT(customer_id)) OVER (PARTITION BY age_group), 2) AS pct_share
FROM customers
GROUP BY age_group, channel
ORDER BY age_group, total_customers DESC;

-- Q31. Subscription rate by season
SELECT 
    season,
    COUNT(customer_id)            AS total_customers,
    SUM(CASE WHEN subscription_status = 'Yes' THEN 1 ELSE 0 END) AS subscribed,
    ROUND(100.0 * SUM(CASE WHEN subscription_status = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(customer_id), 2)  AS subscription_rate_pct
FROM customers
GROUP BY season
ORDER BY subscription_rate_pct DESC;