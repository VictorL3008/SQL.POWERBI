

use CoffeShopDB

CREATE TABLE [Orders] (
    [row_id] int  NOT NULL ,
    [order_id] varchar(10)  NOT NULL ,
    [created_at] datetime  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    [cust_name] varchar(20)  NOT NULL ,
    [in_or_out] varchar(10)  NULL ,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [Items] (
    [item_id] varchar(10)  NOT NULL ,
    [sku] varchar(20)  NOT NULL ,
    [item_name] varchar(100)  NOT NULL ,
    [item_cat] varchar(50)  NOT NULL ,
    [item_size] varchar(10)  NOT NULL ,
    [item_price] decimal(10,2)  NOT NULL ,
    CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

CREATE TABLE [Recipes] (
    [row_id] int  NOT NULL ,
    [recipe_id] varchar(20)  NOT NULL ,
    [ing_id] varchar(20)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [Ingredients] (
    [ing_id] varchar(20)  NOT NULL ,
    [ing_name] varchar(100)  NOT NULL ,
    [ing_weight] int  NOT NULL ,
    [ing_meas] varchar(20)  NOT NULL ,
    [ing_price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED (
        [ing_id] ASC
    )
)

CREATE TABLE [Inventory] (
    [inv_id] varchar(20)  NOT NULL ,
    [ing_id] varchar(20)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED (
        [inv_id] ASC
    )
)

CREATE TABLE [Staff] (
    [staff_id] varchar(20)  NOT NULL ,
    [first_name] varchar(20)  NOT NULL ,
    [last_name] varchar(20)  NOT NULL ,
    [position] varchar(20)  NOT NULL ,
    [sal_per_hour] int  NOT NULL ,
    CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED (
        [staff_id] ASC
    )
)

CREATE TABLE [Shift] (
    [shift_id] varchar(20)  NOT NULL ,
    [day_of_week] varchar(10)  NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL ,
    CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED (
        [shift_id] ASC
    )
)

CREATE TABLE [Rota] (
    [row_id] int  NOT NULL ,
    [rota_id] varchar(20)  NOT NULL ,
    [date] datetime  NOT NULL ,
    [shift_id] varchar(20)  NOT NULL ,
    [staff_id] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_Rota] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)
