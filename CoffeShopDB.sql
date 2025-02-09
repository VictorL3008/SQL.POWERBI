
-- Dashboard 1:

-- Order Activity --

-- For this, we need the following data --
-- Query --
SELECT 
o.order_id, -- Total orders --
i.[ item_price ], -- Total sales and average order value --
o.quantity, -- Total items --
i.item_cat, -- Sales by category --
i.item_name, -- Best-selling items --
o.created_at -- Orders and sales by hour --
FROM orders o 
LEFT JOIN items I ON O.item_id = I.item_id
;

-- Dashboard 2:

 -- Inventory Management --

 -- For this, we need:

 -- 1.- Total quantity of ingredients
-- 2.- Total cost of ingredients
-- 3.- Calculate the cost of items
-- 4.- Percentage of remaining stock per ingredient
-- 5.- List of ingredients to reorder based on remaining stock
-- 6.- Calculate staff salary

 -- Query for points 1, 2, and 3 --
 SELECT 
 S1.item_name,
 S1.ing_id,
 S1.ing_name,
 S1.ing_weight,
 S1.ing_price,
 S1.Order_quantity,
 S1.recipe_quantity,
 S1.Order_quantity*S1.recipe_quantity AS Ordered_weight, -- Total quantity of ingredients --
 S1.ing_price/S1.ing_weight AS Unit_cost,  -- Total cost of ingredients --
 (S1.Order_quantity*S1.recipe_quantity)*(S1.ing_price/S1.ing_weight) AS Ingredient_cost -- Cost of items --
 FROM (SELECT 
 O.item_id,
 I.sku,
 I.item_name,
 R.ing_id,
 ING.ing_name,
 R.quantity AS recipe_quantity,
 SUM( o.quantity ) AS Order_quantity,
 ING.ing_weight,
 ING.ing_price
 FROM orders O 
  LEFT JOIN items I ON O.item_id = I.item_id
  LEFT JOIN recipes R ON I.sku = R.recipe_id
  LEFT JOIN ingredients ING ON R.ing_id = ING.ing_id
GROUP BY 
O.item_id,
 I.sku,
 I.item_name,
 R.ing_id,
 ING.ing_name,
 R.quantity,
 ING.ing_weight,
 ING.ing_price) S1 
 ;


 -- Query for points 4 and 5 --

 SELECT
  s2.ing_name,
  s2.Ordered_weight,
  ing.ing_weight * inv.quantity AS total_inv_weight, -- Percentage of remaining stock per ingredient --
  (ing.ing_weight * inv.quantity)-s2.Ordered_weight as remaining_weight -- List of ingredients to reorder based on remaining stock --
FROM (SELECT 
ing_id,
ing_name,
 SUM(ordered_weight) AS Ordered_weight
FROM
 stock_1 -- Stock1 is a view from the previous query --
 GROUP BY 
 ing_name,ing_id) s2
 LEFT JOIN inventory inv ON inv.ing_id = s2.ing_id
 LEFT JOIN ingredients ing on ing.ing_id = s2.ing_id

 ;
 
-- Query for point 6 --

-- Remove time from dates --


ALTER TABLE rota
ALTER COLUMN date DATE
;

-- Remove dates from times --

ALTER TABLE shift
ALTER COLUMN start_time TIME

;

ALTER TABLE shift
ALTER COLUMN end_time TIME

;


-- Query --
SELECT 
R.date,
S.first_name,
S.last_name,
S.sal_per_hour,
SH.start_time,
SH.end_time,
(datediff(minute,sh.end_time,sh.start_time))/60 as hours_in_shift,
(datediff(minute,sh.end_time,sh.start_time))/60*s.sal_per_hour as staff_cost -- Calculate staff salary --
FROM rota R 
LEFT JOIN staff S ON R.staff_id = S.staff_id
LEFT JOIN shift SH ON R.shift_id = SH.shift_id

;

