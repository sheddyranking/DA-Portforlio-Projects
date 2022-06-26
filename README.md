## Data-Analyst-Portforlio-Projects

 DA-Portfolio Projects with Python, SQL and Tableau Build From Scratch 
 
### Project 1.  SQL Data Exploration.(Covid_19 Dataset)

##### The SQL Exploratory Queries 

> https://github.com/sheddyranking/DA-Portforlio-Projects/blob/main/1.SQL%20Data%20Exploration/Data_Exploration.sql

#####  The Exploratory Tables To be used In Project Two.

> https://github.com/sheddyranking/DA-Portforlio-Projects/tree/main/1.SQL%20Data%20Exploration/Exploratory%20Tables


###### Note:
>  When importing Excel Workbook Data into the Microsoft SQL Studio, Open the SQL Import and Export Wizard Directly Else you will hit an Error. 

>  Red error lines on SQL temp tables: 

> You need to rebuild your IntelliSense cache, The SSMS keyboard shortcut for this is `CTRL`+`SHIFT`+`R`.

> Alternatively, you can go to Edit → IntelliSense → Refresh Local Cache.

> Use the `Cast` Function to Rename a Column DataType

> The common table expression (CTE) is a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. You can also use a CTE in a CREATE a view, as part of the view's SELECT query.

>  IF the Number of Columns in the CTE is different from the Reference Statement it's gonna give an Error.

> Database `view`'s can be used to Store Exploratory Data into Tables for Data Visualizations


### Project 2. Tableau Visualization.

##### Covid19 Analysis Dasboard 

`The Visual Consist:`

> Global Numbering 

> Total Deaths Per Continent 

> Avergae Percentage Population Infected per country (Selected)

> Percentage Population Infected Per Country On a Map.

###### PowerPoint Presentation 
>https://github.com/sheddyranking/DA-Portforlio-Projects/blob/main/2.Tableau%20Visualization/Covid19%20Dashboard.pptx

![World Covid19 Analysis Dashboard ](https://user-images.githubusercontent.com/42388234/173252777-fe036f98-dd2e-4073-b4d9-92094fdff3f5.png)


### Project 3. Data Cleaning in SQL. (Nashville Housising Dataset)

> https://github.com/sheddyranking/DA-Portforlio-Projects/blob/main/3.Data%20Cleaning%20in%20%20SQl/Data%20cleaning%20in%20sql.sql  
###### Note:
> When ever Excel Columns Generate NULL Values when Imported into SSMS, save the worksheet as .CSV and import as a flat file from task when reviewing the data, uncheck the DataTypes indicator. 

> When Splitting an Address the `PARSENAME` Function is more preferable to `SUBSTRINGS`

### Project 4. Correlation In Python (Movie Dataset) 

> https://github.com/sheddyranking/DA-Portforlio-Projects/blob/main/4.Correlation%20In%20Python/%20Correlation_Python.ipynb

###### NOTE:
>  Errors such as `Cannot convert non-finite values (NA or inf) to integer`,  Use the `df['column_name'].apply(pd.to_numeric).astype('Int64')` to allow Nullable Integers Coexist with NaNs.

###### Budget vs gross comparison

![Budvsgross](https://user-images.githubusercontent.com/42388234/175798476-12ef125e-09b3-4e58-98f8-8f6815c987c8.png)

