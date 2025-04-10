SELECT * FROM sys.tv_final;
-- 1. Average selling price per brand
SELECT Brand, AVG(`Selling Price`) AS avg_price
FROM tv_final
GROUP BY Brand
ORDER BY avg_price DESC;

-- 2. TVs with a rating above 4.4
SELECT * FROM tv_final
WHERE Rating > 4.4
ORDER BY Rating DESC;

-- 3. Count of TVs by resolution
SELECT Resolution, COUNT(*) AS total
FROM tv_final
GROUP BY Resolution
ORDER BY total DESC;

-- b. JOIN (Create a sample table for demonstration)

-- Drop if exists to avoid conflicts
DROP TABLE IF EXISTS os_details;


CREATE TABLE os_details (
    `Operating System` VARCHAR(50),
    Platform_Type VARCHAR(50)
);


INSERT INTO os_details VALUES
('Android', 'Smart TV'),
('VIDAA', 'Smart TV'),
('Tizen', 'Smart TV'),
('Linux', 'Basic Smart');


SELECT tv.Brand, tv.`Operating System`, os.Platform_Type
FROM tv_final tv
INNER JOIN os_details os
ON tv.`Operating System` = os.`Operating System`;

-- c. Subquery: TVs priced below average original price
SELECT * FROM tv_final
WHERE `Original Price` < (
  SELECT AVG(`Original Price`) FROM tv_final
);

-- d. Aggregate Functions

-- 1. Total discount offered by brand
SELECT Brand, SUM(`Original Price` - `Selling Price`) AS total_discount
FROM tv_final
GROUP BY Brand;

-- 2. Average rating by resolution
SELECT Resolution, AVG(Rating) AS avg_rating
FROM tv_final
GROUP BY Resolution;

-- e. Views

-- Drop existing view if needed
DROP VIEW IF EXISTS brand_price_summary;

-- Create view for price summary by brand
CREATE VIEW brand_price_summary AS
SELECT Brand,
       AVG(`Selling Price`) AS avg_selling_price,
       AVG(`Original Price`) AS avg_original_price
FROM tv_final
GROUP BY Brand;

-- Use the view
SELECT * FROM brand_price_summary;

-- f. Index Optimization

-- Create indexes for optimization
CREATE INDEX idx_brand ON tv_final(Brand);
CREATE INDEX idx_rating ON tv_final(Rating);

