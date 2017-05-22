use AdventureWorksDW2012;

/*Employees whose birthday is in Feburary*/
SELECT *
FROM DimEmployee
WHERE Month(BirthDate) = 2;
 
/*who are the Sales Representatives whose birthday is in Feburary?*/
SELECT FirstName, LastName, BirthDate
FROM DimEmployee
WHERE Month(BirthDate) = 2 AND Title = 'Sales Representative';

/*List all the sales processed by these Sales Representatives */
SELECT S.*, E.FirstName, E.LastName, E.BirthDate, E.Title
FROM FactResellerSales as S
INNER JOIN DimEmployee as E
on S.EmployeeKey = E.EmployeeKey
WHERE Month(BirthDate) = 2 AND Title = 'Sales Representative';

/*who is a better sales representative that was born in Feburary?*/
SELECT Sum(SalesAmount) as TotalAmount, FirstName, LastName
FROM FactResellerSales as S
INNER JOIN DimEmployee as E
on S.EmployeeKey = E.EmployeeKey
WHERE Month(BirthDate) = 2 AND Title = 'Sales Representative'
GROUP BY FirstName, LastName
Order By SUM(SalesAmount) DESC;

/*total Amount of off-line sales in Massachusetts*/
Select SUM(S.SalesAmount) as Total_Offline_Sales, G.StateProvinceName
 From FactResellerSales as S, DimGeography as G
 Where S.SalesTerritoryKey = G.SalesTerritoryKey
 And G.StateProvinceName = 'Massachusetts'
 Group By G.StateProvinceName

/*Total Amount of Internet Sales in 1st quarter each year in each country*/
Select SUM(S.SalesAmount) as Internet_Sales_Total_1st_Q, G.CountryRegionCode
 From FactInternetSales as S, DimDate as D, DimGeography as G
 Where S.DueDateKey = D.DateKey
 And D.FiscalQuarter = '1'
 Group By G.CountryRegionCode