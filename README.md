### What I have done
1) Created a git repository.
2) Created a database name 'dev', schema 'dev' & 3 tables in redshift.
3) Created a project in dbt cloud and linked with GitHub. 
4) Github link: https://github.com/samiul24/dbt-cloud/tree/samiul24-patch-1


### Summary of Deliverables:
1) Refactored SQL Code: Split into modular dbt models (stg_marketing_events, stg_sales_transactions, stg_product_catalog, and agg_marketing_sales_performance).
2) Data Quality Tests: Added to schema.yml to ensure data integrity.
3) dbt Macro: Created calculate_revenue_to_cost_ratio for reusability.
4) Documentation: Added descriptions for each model and key columns in schema.yml

### Sample tables in Redshift:
CREATE TABLE dev.dev.marketing_events (
    event_id INT IDENTITY(1,1) PRIMARY KEY,  
    user_id INT NOT NULL,                  
    event_type VARCHAR(50),                  
    event_timestamp TIMESTAMP NOT NULL,      
    channel VARCHAR(50),                     
    campaign VARCHAR(100),                    
    cost DECIMAL(18,2)                        
)
DISTKEY(user_id)  
SORTKEY(event_timestamp);  

INSERT INTO dev.dev.marketing_events (user_id, event_type, event_timestamp, channel, campaign, cost) VALUES
(101, 'ad_click', '2024-03-01 10:30:00', 'Google Ads', 'Spring Sale', 5.50),
(102, 'email_open', '2024-03-02 11:15:00', 'Email', 'New Arrivals', 1.20),
(103, 'ad_click', '2024-03-03 12:45:00', 'Facebook', '50% Off', 4.75),
(104, 'ad_click', '2024-03-05 14:00:00', 'Instagram', 'Exclusive Offer', 3.60),
(105, 'email_open', '2024-03-06 16:30:00', 'Email', 'Special Promo', 1.00);


CREATE TABLE dev.dev.sales_transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,  
    product_id INT NOT NULL,                       
    user_id INT NOT NULL,                          
    transaction_timestamp TIMESTAMP NOT NULL,      
    revenue DECIMAL(18,2) NOT NULL,                
    cost DECIMAL(18,2) NOT NULL                    
)
DISTKEY(user_id)  
SORTKEY(transaction_timestamp);  

INSERT INTO dev.dev.sales_transactions (product_id, user_id, transaction_timestamp, revenue, cost) VALUES
(1, 101, '2024-03-02 12:00:00', 999.99, 700.00),  
(2, 102, '2024-03-03 15:45:00', 899.99, 650.00),  
(3, 103, '2024-03-04 17:30:00', 150.00, 80.00),   
(4, 104, '2024-03-06 10:15:00', 180.00, 100.00),  
(5, 105, '2024-03-07 13:20:00', 350.00, 200.00);  


CREATE TABLE dev.dev.product_catalog (
    product_id INT IDENTITY(1,1) PRIMARY KEY,  
    product_name VARCHAR(255) NOT NULL,        
    category VARCHAR(100) NOT NULL             
)
DISTSTYLE ALL;  

INSERT INTO dev.dev.product_catalog (product_name, category) VALUES
('iPhone 15', 'Electronics'),
('Samsung Galaxy S23', 'Electronics'),
('Nike Air Max', 'Footwear'),
('Adidas Ultraboost', 'Footwear'),
('Sony WH-1000XM5', 'Accessories');



