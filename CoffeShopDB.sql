
-- Dashboard 1: 

 -- Actividad de ordenes --

-- Para eso necesitamos los siguientes datos --

-- Query --
SELECT 
o.order_id, -- Total de ordenes --
i.[ item_price ], -- Total de ventas y valor promedio de ordenes -- 
o.quantity, -- Total de artículos --
i.item_cat, -- Ventas por categoría --
i.item_name, -- Artículos mas vendidos --
o.created_at -- Ordenes y ventas por hora --
FROM orders o 
LEFT JOIN items I ON O.item_id = I.item_id
;

-- Dashboard 2:

 -- Administración de inventario --

 -- para esto necesitamos: 

 -- 1.- Cantidad total de ingredientes
 -- 2.- Costo total de ingredientes
 -- 3.- Calcular el costo de articulos
 -- 4.- Porcentaje de stock restante por ingrediente 
 -- 5.- Lista de ingredientes para re-ordenar basado en el stock restante
 -- 6.- Calcular salario de los trabajadores

 -- Query para punto 1 , 2 y 3 --
 SELECT 
 S1.item_name,
 S1.ing_id,
 S1.ing_name,
 S1.ing_weight,
 S1.ing_price,
 S1.Order_quantity,
 S1.recipe_quantity,
 S1.Order_quantity*S1.recipe_quantity AS Ordered_weight, -- Cantidad total de ingredientes --
 S1.ing_price/S1.ing_weight AS Unit_cost, -- Costo total de ingredientes --
 (S1.Order_quantity*S1.recipe_quantity)*(S1.ing_price/S1.ing_weight) AS Ingredient_cost --Costo de articulos -- 
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


 -- Query para punto 4 y 5 --

 SELECT
  s2.ing_name,
  s2.Ordered_weight,
  ing.ing_weight * inv.quantity AS total_inv_weight, --Porcentaje de stock restante por ingrediente --
  (ing.ing_weight * inv.quantity)-s2.Ordered_weight as remaining_weight --Lista de ingredientes para re-ordenar basado en el stock restante --
FROM (SELECT 
ing_id,
ing_name,
 SUM(ordered_weight) AS Ordered_weight
FROM
 stock_1 -- Stock1 es una vista del query anterior --
 GROUP BY 
 ing_name,ing_id) s2
 LEFT JOIN inventory inv ON inv.ing_id = s2.ing_id
 LEFT JOIN ingredients ing on ing.ing_id = s2.ing_id

 ;
 
 -- Query para punto 6 --

 -- Quitar horas de las fechas --

ALTER TABLE rota
ALTER COLUMN date DATE
;

-- Quitar fechas de las horas --

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
(datediff(minute,sh.end_time,sh.start_time))/60*s.sal_per_hour as staff_cost -- Calcular salario de los trabajadores --
FROM rota R 
LEFT JOIN staff S ON R.staff_id = S.staff_id
LEFT JOIN shift SH ON R.shift_id = SH.shift_id

;

