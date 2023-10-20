--This project is an exploratory analysis to understand the sales behaviour 
--of Kings Marine Ltd for the month of september to october.

--The Result of the Analysis will be used to improve upon the business to 
--increase Profit and reduce loss(normmally due to high inflation rate)

--Let's look at the data

Select *
from PortfolioProject2..MonthSaleRecord

--Let's clean the date column to improve upon the usability of the data.

Select NewDate,CONVERT(date,date)
from PortfolioProject2..MonthSaleRecord

update MonthSaleRecord
set date = CONVERT(date,date)

Alter Table MonthsaleRecord
Add Newdate date;

update MonthSaleRecord
set NewDate = CONVERT(date,date)


--The NULL values in the Engine type column is correct
--because not all items have a specific engine type.

--Let's calculate the profit per unit item
select Quantity,Items,[Unit price],[Sum Price],[Cost price],Newdate,([Unit price]-[Cost price]) as profit_per_unit
from PortfolioProject2..MonthSaleRecord
order by Newdate


--Let's calculate the total profit per quantity
select Quantity,Items,[Unit price],[Sum Price],[Cost price],Newdate,([Unit price]-[Cost price])*Quantity as total_profit
from PortfolioProject2..MonthSaleRecord
order by Newdate




--Calculate profit percentage using a  CTE.
with salerecord(Quantity,Items,[Unit price],[Sum Price],[Cost price],Newdate,total_profit)
as
(
select Quantity,Items,[Unit price],[Sum Price],[Cost price],Newdate,([Unit price]-[Cost price])*Quantity as total_profit
from PortfolioProject2..MonthSaleRecord
--order by Newdate
)
--Calculate the Daily Profit and Profit Percentage per Item
select *,(total_profit/[Sum Price])*100 as Profit_percentage,
SUM(total_profit) OVER (Partition by Newdate order by Newdate) as DailyProfit
from salerecord



--On the 20th of September,2021, we recorded our best sales for the month 
--And on the 21st September,2021,we had the worst sales for the month.

-- The Items with the Highest Profit Percentage are Cap pin,Propeller pin and Impeller key.
-- The Items with the Lowest Profit Percentage are Packet of plug org,Abro blue gum.

--This Analysis helped me to learn more about my sales activity for the month of september-october.

-- Taken the result of the analysis in mind,I will mindfully work towards improvement of the sales and increasing profit.








