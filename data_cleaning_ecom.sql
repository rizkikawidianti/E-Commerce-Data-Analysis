-- 1. Checking duplicate values
-- checking duplicate in raw table first, before moving it to the staging table
with duplicate as(
	select *,
		row_number() over(partition by order_id,order_date,region,destination_city,category,payment_method ,sales_amount,discount_pct,quantity,return_status,customer_type ) as row_num
	from ecommerce_orders
)
select * from duplicate
where row_num >1
order by order_id asc

-- create staging table to safely clean and transform data without modifying the original raw dataset
CREATE TABLE ecommerce_staging (
  `order_id` varchar(50) DEFAULT NULL,
  `order_date` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `destination_city` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `sales_amount` varchar(50) DEFAULT NULL,
  `discount_pct` varchar(50) DEFAULT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `return_status` varchar(50) DEFAULT NULL,
  `customer_type` varchar(50) DEFAULT null,
  `row_num` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- insert value from raw table and added row_num for flagging the duplicate values
insert into ecommerce_staging select *,
	row_number() over(partition by order_id,order_date,region,destination_city,category,payment_method,sales_amount,discount_pct,quantity,return_status,customer_type ) as row_num
from ecommerce_orders

-- removing duplicates
delete from ecommerce_staging 
where row_num >1

-- after exploration, find out of some rows with the same order_id but not duplicate
with duplicate_ids as (
	select order_id, count(*)
	from ecommerce_staging
	group by order_id
	having count(*) > 1
)
select *
from ecommerce_staging
where order_id in (select order_id from duplicate_ids)
order by order_id, order_date asc;

-- Removed inconsistent duplicate where payment_method was invalid ('N/A')
-- Kept the valid record for this order_id
delete from ecommerce_staging 
where order_id= 'ORD-101519' and payment_method = 'N/A'

-- remove the duplicate row with the same order_id so it wont affect monthly trends and order counts on analysis
delete from ecommerce_staging 
where order_id in ('ORD-103231','ORD-103756','ORD-104096')

-- Check remaining duplicates
select order_id, count(*)
from ecommerce_staging
group by order_id
having count(*) > 1;


-- 2. Standardize missing and inconsistent values, to ensure consistent handling of missing data
alter table ecommerce_staging
add column new_discount_pct int

update ecommerce_staging
set new_discount_pct = case
	when discount_pct like '' or discount_pct like '%N/A%' then null
	else trim(discount_pct)
end

update ecommerce_staging
set return_status = case
	when return_status like '' then null
	else trim(proper(return_status))
end


-- 3. Fix invalid date formats, to enable accurate time-based analysis
alter table ecommerce_staging
add column new_order_date date

update ecommerce_staging
set new_order_date = case
	when order_date LIKE '__/%/%' 
         THEN STR_TO_DATE(order_date, '%m/%d/%Y')
	when order_date LIKE '____/%/%' 
            THEN STR_TO_DATE(order_date, '%Y/%m/%d')
     else order_date
end 


-- 4. Convert data types, to allow numerical calculations and validation
alter table ecommerce_staging 
modify column sales_amount decimal(15,5),
modify column quantity int null



-- 5. Delete the raw column and renaming the cleaned column
alter table ecommerce_staging 
drop order_date,
drop discount_pct,
drop row_num

-- row_num is the column for flagging the duplicate value, removing it after deleting the duplicates

alter table ecommerce_staging 
rename column new_order_date to order_date,
rename column new_discount_pct to discount_pct

-- 6. Validation, to ensure data quality after cleaning
select count(*) from ecommerce_staging where discount_pct is null;
select count(*) from ecommerce_staging where return_status is null;









