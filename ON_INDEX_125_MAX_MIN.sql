--הפרשים לפני שבוע, חודש,רבעון,חצי שנה,שנה,שנתיים,3,4,5,10 מהתאריך הזה
SELECT d.TheDate,t.Opening_index, t.Closing_index,d.TheDayOfWeek 
,LAG(t.Closing_index,7 )OVER (ORDER BY T.DATE )closing_index_7d_of_markating,
t.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY T.DATE ) SALE_7_D_DIFF_market,
FORMAT(((t.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY T.DATE ))/t.Opening_index),'p')p_diff_day_matk,
LAG(t.Closing_index,7 )OVER (ORDER BY d.TheDate )closing_index_7d,
t.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY d.TheDate ) SALE_7_D_DIFF_days,
FORMAT(((t.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY d.TheDate ))/t.Opening_index),'p')p_diff_day
FROM [dbo].[TLV_125] t right join [dbo].[DateDimension] d
ON t.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY d.TheDate DESC

--הפרש 30 יום 
SELECT d.TheDate,t.Opening_index, t.Closing_index,d.TheDayOfWeek 
,LAG(t.Closing_index,30 )OVER (ORDER BY T.DATE )closing_index_30d_of_markating,
t.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY T.DATE ) SALE_30_D_DIFF_market,
FORMAT(((t.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY T.DATE ))/t.Opening_index),'p')p_diff_day_matk,
LAG(t.Closing_index,30 )OVER (ORDER BY d.TheDate )closing_index_30d,
t.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY d.TheDate ) SALE_30_D_DIFF_days,
FORMAT(((t.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY d.TheDate ))/t.Opening_index),'p')p_diff_day
FROM [dbo].[TLV_125] t right join [dbo].[DateDimension] d
ON t.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY d.TheDate DESC

-- הפרש 90 יום 
SELECT d.TheDate,t.Opening_index, t.Closing_index,d.TheDayOfWeek 
,LAG(t.Closing_index,90 )OVER (ORDER BY T.DATE )closing_index_90d_of_markating,
t.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY T.DATE ) SALE_90_D_DIFF_market,
FORMAT(((t.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY T.DATE ))/t.Opening_index),'p')p_diff_day_matk,
LAG(t.Closing_index,90 )OVER (ORDER BY d.TheDate )closing_index_90d,
t.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY d.TheDate ) SALE_90_D_DIFF_days,
FORMAT(((t.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY d.TheDate ))/t.Opening_index),'p')p_diff_day
FROM [dbo].[TLV_125] t right join [dbo].[DateDimension] d
ON t.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY d.TheDate DESC

CREATE VIEW DIFFERENCES_BETWEEN_SALE_AND_BUY AS
SELECT d.TheDate, t.Closing_index,T.Opening_index,d.TheDayOfWeek ,
FORMAT(((T.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_7_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,7 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_7_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_30_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,30 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_30_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_90_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,90 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_90_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,180 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_180_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,180 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_180_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,365 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_365_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,365 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_365_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,730 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_730_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,730 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_730_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1095 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_1095_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1095 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_1095_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1460 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_1460_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1460)OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_1460_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1825 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_1825_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,1825 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_1825_D_DIFF_ALLDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,3650 )OVER (ORDER BY T.DATE ))/T.Opening_index),'P') SALE_3650_D_DIFF_MARKETDAYS,
FORMAT(((T.Opening_index -LAG(t.Closing_index,3650 )OVER (ORDER BY d.TheDate ))/T.Opening_index),'P') SALE_3650_D_DIFF_ALLDAYS
FROM [dbo].[TLV_125] t right join [dbo].[DateDimension] d
ON t.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY d.TheDate DESC


SELECT *
FROM [dbo].[DateDimension] d

--הממד סגירה הכי גבוה ב20 השנה 
select MAX(t.Closing_index) MAX_CLOSIND_INDEX_20_YEARS from [dbo].[TLV_125] t  

-- המדד הכי נמוך ב20 שנה
select MIN(t.Closing_index) MAX_CLOSIND_INDEX_20_YEARS from [dbo].[TLV_125] t 



--  90 ' 180,מדד  ממוצע 7 ימים, 30 יום 60 יום

WITH AVG_DAY AS(
SELECT  T.DATE,T.Highest_index , T.Lowest_index,
(T.Highest_index + T.Lowest_index+T.Base_index)/3  AVG_INDEX
FROM [dbo].[TLV_125] T
)SELECT d.TheDate,AVG_INDEX, 
AVG(A.AVG_INDEX) OVER(ORDER BY d.TheDate ROWS BETWEEN 6 PRECEDING AND 0 FOLLOWING)AVG_7_D,
AVG(A.AVG_INDEX) OVER(ORDER BY d.TheDate ROWS BETWEEN 29 PRECEDING AND 0 FOLLOWING)AVG_30_D,
AVG(A.AVG_INDEX) OVER(ORDER BY d.TheDate ROWS BETWEEN 59 PRECEDING AND 0 FOLLOWING)AVG_60_D,
AVG(A.AVG_INDEX) OVER(ORDER BY d.TheDate ROWS BETWEEN 89 PRECEDING AND 0 FOLLOWING)AVG_90_D,
AVG(A.AVG_INDEX) OVER(ORDER BY d.TheDate ROWS BETWEEN 179 PRECEDING AND 0 FOLLOWING)AVG_180_D
FROM AVG_DAY A right join [dbo].[DateDimension] d
ON A.Date = d.TheDate 
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY  d.TheDate DESC

CREATE VIEW ALL_INDEX AS
SELECT T_125.Date,T_125.Closing_index AS T_125_Closing_index,
T_B.Closing_index AS T_Biomed_Closing_index,T_35.Closing_index AS
T_35_Closing_index,T_CL.Closing_index AS T_Cleantech_Closing_index,
T_CO.Closing_index AS T_Construction_Closing_index,
T_FI.Closing_index AS T_Finances_Closing_index,
T_IN.Closing_index AS T_Insurance_Closing_index,
T_gr.Closing_index AS T_Growth_Closing_index,
T_O_G.Closing_index AS T_OilANDGas_Closing_index,
T_R_E.Closing_index AS T_RealEstate_Closing_index,
T_BA.Closing_index AS T_Banks_Closing_index
FROM [dbo].[TLV_125] T_125 RIGHT JOIN  [dbo].[DateDimension] D
ON  T_125.Date = D.TheDate  LEFT JOIN [dbo].[TLV_Biomed] T_B 
ON D.TheDate = T_B.DATE  LEFT JOIN [dbo].[TLV_35] T_35
ON D.TheDate = T_35.Date LEFT JOIN [dbo].[TLV_Cleantech] T_CL 
ON D.TheDate = T_CL.Date LEFT JOIN [dbo].[TLV_Construction] T_CO
ON D.TheDate = T_CO.Date LEFT JOIN [dbo].[TLV_Finances] T_FI
ON  D.TheDate = T_FI.Date LEFT JOIN [dbo].[TLV_Insurance] T_IN
ON D.TheDate = T_IN.Date LEFT JOIN [dbo].[TLV_Growth] T_gr
ON D.TheDate = T_gr.Date LEFT JOIN [dbo].[TLV_Oil&Gas] T_O_G
ON D.TheDate = T_O_G.Date LEFT JOIN [dbo].[TLV_RealEstate] T_R_E
ON D.TheDate = T_R_E.Date LEFT JOIN [dbo].[TLV_Banks] T_BA
ON D.TheDate = T_BA.DATE
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' 

-- כל המדדים
ALTER VIEW D_Construction_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Construction_Closing_index,D.TheDayOfWeek
,IIF(AI.T_Construction_Closing_index>LAG (AI.T_Construction_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsNagtiveConstructionClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY T.TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW DB_Finances_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Finances_Closing_index,D.TheDayOfWeek
,IIF(AI.T_Finances_Closing_index>LAG (AI.T_Finances_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositiveFinancesClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW DB_Growth_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Growth_Closing_index,D.TheDayOfWeek
,IIF(AI.T_Growth_Closing_index>LAG (AI.T_Growth_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositiveGrowthClosingindex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW DB_RealEstate_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_RealEstate_Closing_index,D.TheDayOfWeek
,IIF(AI.T_RealEstate_Closing_index>LAG (AI.T_RealEstate_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositiveRealEstateClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW DB_OilANDGas_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_OilANDGas_Closing_index,D.TheDayOfWeek
,IIF(AI.T_OilANDGas_Closing_index>LAG (AI.T_OilANDGas_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositiveOilANDGasClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW _125_Closing_index AS
WITH PROFIT_D_Positive AS(
SELECT AI.Date, AI.T_125_Closing_index,D.TheDayOfWeek
,IIF(AI.T_125_Closing_index>LAG (AI.T_125_Closing_index) 
OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositive125Closingindex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek



ALTER VIEW D_35_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_35_Closing_index,D.TheDayOfWeek
,IIF(AI.T_35_Closing_index>LAG (AI.T_35_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositive35Closingindex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW D_Banks_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Banks_Closing_index,D.TheDayOfWeek
,IIF( AI.T_Banks_Closing_index>LAG ( AI.T_Banks_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositiveBanksClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW D_Biomed_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Biomed_Closing_index,D.TheDayOfWeek
,IIF( AI.T_Biomed_Closing_index>LAG ( AI.T_Biomed_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek) CountTheNumIsPositiveBiomedClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW D_Cleantech_Closing_index AS
WITH PROFIT_T AS(
SELECT AI.Date, AI.T_Cleantech_Closing_index,D.TheDayOfWeek
,IIF( AI.T_Cleantech_Closing_index>LAG ( AI.T_Cleantech_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek) CountTheNumIsPositiveCleantechClosingIndex
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

ALTER VIEW DB_Insurance_Closing_index AS
WITH PROFIT_DAY AS(
SELECT AI.Date, AI.T_Insurance_Closing_index,D.TheDayOfWeek
,IIF(AI.T_Insurance_Closing_index>LAG ( AI.T_Insurance_Closing_index) OVER(ORDER BY AI.Date), '+', '-') AS PROFIT
FROM ALL_INDEX AI LEFT JOIN [dbo].[DateDimension] d
ON AI.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek) CountTheNumIsPositiveInsuranceClosingIndex
FROM PROFIT_DAY T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek



SELECT F.TheDayOfWeek,F.CountTheNumIsNagtiveFinancesClosingIndex,
C125.CountTheNumIsNagtive125ClosingIndex,C35.CountTheNumIsNagtive35Closingindex,
B.CountTheNumIsNagtiveBanksClosingIndex,BI.CountTheNumIsNagtiveBiomedClosingIndex,
CL.CountTheNumIsNagtiveCleantechClosingIndex
,CO.CountTheNumIsNagtiveConstructionClosingIndex,G.CountTheNumIsNagtiveGrowthClosingindex
,I.CountTheNumIsNagtiveInsuranceClosingIndex,OG.CountTheNumIsNagtiveOilANDGasClosingIndex,
RE.CountTheNumIsNagtiveRealEstateClosingIndex
FROM DB_Finances_Closing_index F  JOIN  
_125_Closing_index C125 ON F.TheDayOfWeek = C125.TheDayOfWeek JOIN 
D_35_Closing_index C35 ON F.TheDayOfWeek = C35.TheDayOfWeek JOIN
D_Banks_Closing_index B ON F.TheDayOfWeek = B.TheDayOfWeek
JOIN D_Biomed_Closing_index BI ON F.TheDayOfWeek = BI.TheDayOfWeek JOIN 
D_Cleantech_Closing_index CL ON F.TheDayOfWeek = CL.TheDayOfWeek 
JOIN D_Construction_Closing_index CO ON F.TheDayOfWeek = CO.TheDayOfWeek  JOIN 
DB_Growth_Closing_index  G ON F.TheDayOfWeek = G.TheDayOfWeek JOIN 
DB_Insurance_Closing_index I  ON F.TheDayOfWeek = I.TheDayOfWeek JOIN 
DB_OilANDGas_Closing_index OG ON F.TheDayOfWeek = OG.TheDayOfWeek JOIN 
DB_RealEstate_Closing_index RE ON F.TheDayOfWeek = RE.TheDayOfWeek 
ORDER BY F.TheDayOfWeek




SELECT *
FROM DB_OilANDGas_Closing_index
-- האם יש השפעה לימים בשבוע  על עלייה  
WITH PROFIT_T AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM TLV_125 T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsPositive
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek

-- האם יש השפעה לימים בשבוע על  ירידה 
WITH PROFIT_T AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM TLV_125 T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT T.TheDayOfWeek, COUNT(TheDayOfWeek)CountTheNumIsNagtive
FROM PROFIT_T T
WHERE PROFIT ='-'
GROUP BY TheDayOfWeek
ORDER BY TheDayOfWeek


--השפעה על יום בחודש על ירידה
WITH PROFIT_MON AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM [dbo].[TLV_Finances] T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT  day(t.Date)DayOfMonth, COUNT(day(t.Date))CountTheNumIsNagtiveTLV_Finances
FROM PROFIT_MON  T
WHERE PROFIT ='-'
GROUP BY day(t.Date)
ORDER BY day(t.Date)

--השפעה על יום בחודש על עלייה 

WITH PROFIT_T AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM [dbo].[TLV_RealEstate] T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT day(t.Date) DayOfMonth, COUNT(day(t.Date)) CountTheNumIsPositiveTLV_RealEstate
FROM PROFIT_T T
WHERE PROFIT ='+'
GROUP BY day(t.Date)
ORDER BY day(t.Date)

-- חודש מסוים בשנה עליה 
WITH PROFIT_YEAR AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM TLV_125 T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT MONTH(t.Date) MONTH, COUNT(MONTH(t.Date))CountTheNumIsPositiveForMONTHTLV_125
FROM PROFIT_YEAR T
WHERE PROFIT ='+'
GROUP BY MONTH(t.Date)
ORDER BY MONTH(t.Date)
-- חודש מסוים בשנה ירידה  

WITH PROFIT_T AS(
SELECT T.Date, T.Closing_index ,D.TheDayOfWeek
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM TLV_125 T LEFT JOIN [dbo].[DateDimension] d
ON T.Date = d.TheDate
WHERE d.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT MONTH(t.Date)MONTH, COUNT(MONTH(t.Date))CountTheNumIsNagtiveForMONTHTLV_125
FROM PROFIT_T T
WHERE PROFIT ='-'
GROUP BY MONTH(t.Date)
ORDER BY MONTH(t.Date)

