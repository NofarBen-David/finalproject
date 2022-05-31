-- האם עלייה או ירידה של מדד אחר משפיעה על המדד הזה

SELECT T.Date, T.Closing_index 
,IIF(T.Closing_index>LAG (t.Closing_index) OVER(ORDER BY T.Date), '+', '-') AS PROFIT
FROM TLV_125 T
ORDER BY T.Date DESC

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




-- להכניס לפייתון לבדוק שונות ודמיון בין המדדים 
CREATE VIEW UP_OR_DOWN AS 
SELECT A.DATE,T_125_Closing_index,IIF(T_125_Closing_index>LAG (T_125_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_125_Closing_index is null or LAG (T_125_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_125_Closing_index,
T_35_Closing_index,IIF(T_35_Closing_index>LAG (T_35_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_35_Closing_index is null or LAG (T_35_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_35_Closing_index ,
T_Cleantech_Closing_index,IIF(T_Cleantech_Closing_index>LAG (T_Cleantech_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Cleantech_Closing_index is null or LAG (T_Cleantech_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Cleantech_Closing_index,
T_Construction_Closing_index,IIF(T_Construction_Closing_index>LAG (T_Construction_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Construction_Closing_index is null or LAG (T_Construction_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Construction_Closing_index,
T_Finances_Closing_index,IIF(T_Finances_Closing_index>LAG (T_Finances_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Finances_Closing_index is null or LAG (T_Finances_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Finances_Closing_index,
T_Insurance_Closing_index,IIF(T_Insurance_Closing_index>LAG (T_Insurance_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Insurance_Closing_index is null or LAG (T_Insurance_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Insurance_Closing_index,T_Growth_Closing_index,
IIF(T_Growth_Closing_index>LAG (T_Growth_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Growth_Closing_index is null or LAG (T_Growth_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Growth_Closing_index,
T_OilANDGas_Closing_index,IIF(T_OilANDGas_Closing_index>LAG (T_OilANDGas_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_OilANDGas_Closing_index is null or LAG (T_OilANDGas_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_OilANDGas_Closing_index,
T_RealEstate_Closing_index,IIF(T_RealEstate_Closing_index>LAG (T_RealEstate_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_RealEstate_Closing_index is null or LAG (T_RealEstate_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_RealEstate_Closing_index,
T_Banks_Closing_index,IIF(T_Banks_Closing_index>LAG (T_Banks_Closing_index) 
OVER(ORDER BY A.DATE), '+', IIF(T_Banks_Closing_index is null or LAG (T_Banks_Closing_index) OVER(ORDER BY A.DATE) is null,null,'-')) AS PROFIT_T_Banks_Closing_index
FROM ALL_INDEX A
WHERE A.Date  BETWEEN '2000-01-06' AND '2022-04-07' OR A.Date  <> NULL

ORDER BY A.Date DESC
-- הוצאת ערכים קיצוניים

-- לבדוק בפייתון את השינויים האלה 
WITH THIS AS (
SELECT DATE, Closing_index,Closing_index-LAG (Closing_index) 
OVER(ORDER BY DATE) DIFF_IN_POINTS, ((Closing_index-LAG (Closing_index)
OVER(ORDER BY DATE))  /LAG (Closing_index)
OVER(ORDER BY DATE)) * 100 PRSE_CHANGE
FROM [dbo].[TLV_125])
SELECT SUM(DIFF_IN_POINTS)SUM_CHANGE ,MAX(PRSE_CHANGE)MAX_CHANGE ,MIN(PRSE_CHANGE) MIN_CHANGE,AVG(PRSE_CHANGE)AVG_CHANGE
FROM THIS


-- )להשוות זמנים שקרה משהו בטבלה (ערכים קיצוניים עם נתונים אחרים שמצאתי)
WITH CHANGE_TABLE AS(
SELECT D.TheDate, T.Closing_index,T.Closing_index-LAG (T.Closing_index) 
OVER(ORDER BY D.TheDate) DIFF_IN_POINTS,(T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY D.TheDate))  /LAG (T.Closing_index)
OVER(ORDER BY D.TheDate) PRSE_CHANGE
FROM [dbo].[TLV_125] T RIGHT JOIN DateDimension D
ON T.Date = D.TheDate  LEFT JOIN  [dbo].[Construction_Input_Index]C
ON D.TheDate = C.Start_Date LEFT JOIN [dbo].[Global_Disease_Years] G
ON D.TheDate = G.FK_Date_Table LEFT JOIN [dbo].[Consumer_price_index] CPI
ON  D.TheDate = CPI.Change_Date LEFT JOIN [dbo].[Consumer_Price_Index_USA] CPU
ON D.TheDate = CPU.Start_date  LEFT JOIN [dbo].[Interest_rate_Isreal] IRI
ON D.TheDate = IRI.Start_Date LEFT JOIN [dbo].[Isreal_Wars] IW
ON D.TheDate = IW.Start_Time LEFT JOIN [dbo].[War_WorldWide] WW
ON D.TheDate = WW.Start_Date
WHERE D.TheDate  BETWEEN '2000-01-06' AND '2022-04-07' )
SELECT C.*, AVG(PRSE_CHANGE) OVER ()AVG_CHANGE
FROM CHANGE_TABLE C 


--מדד תשומות הבנייה מול מדד 125 ורווח מחושב חודשי לשינוי כולל ימים בלי מסחר
;
WITH THIS_TABLE AS(
SELECT T.Date,F_T_F.THE_FIFTEEN, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
CII.Index_cons,FORMAT((CII.Index_cons-LAG (CII.Index_cons) 
OVER(ORDER BY T.Date ))/LAG (CII.Index_cons) 
OVER(ORDER BY T.Date),'P') AS DIFF
FROM [dbo].[TLV_125] T  JOIN FIFTEEN_TO_FIFTEEN F_T_F
ON T.Date = F_T_F.TheDate
 LEFT JOIN [dbo].[Construction_Input_Index] CII
ON  F_T_F.THE_FIFTEEN= CII.Start_Date 
) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.THE_FIFTEEN  )
FROM THIS_TABLE T
ORDER BY T.Date 

-- המשך של אותה שאילתה 
CREATE VIEW FIFTEEN_TO_FIFTEEN as
SELECT D.TheDate,  CASE WHEN D.TheDate >= D.The15thOfMonth  THEN D.The15thOfMonth
WHEN D.TheDate < D.The15thOfMonth THEN DATEADD(month, -1,D.The15thOfMonth )END THE_FIFTEEN
FROM [dbo].[DateDimension] D


-- המחירים לצרכן שינוי חודשי מול שינוי במדד
WITH THIS_TABLE AS(
SELECT T.Date,F_T_F.THE_FIFTEEN, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
CPI.Index_CPI ,FORMAT((CPI.Index_CPI-LAG (CPI.Index_CPI) 
OVER(ORDER BY T.Date ))/LAG (CPI.Index_CPI) 
OVER(ORDER BY T.Date ),'P') AS DIFF
FROM [dbo].[TLV_125] T  JOIN FIFTEEN_TO_FIFTEEN F_T_F
ON T.Date = F_T_F.TheDate
 LEFT JOIN [dbo].[Consumer_price_index] CPI
ON  F_T_F.THE_FIFTEEN= CPI.Change_Date) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.THE_FIFTEEN  )
FROM THIS_TABLE T
ORDER BY T.Date 


WITH THIS_TABLE AS(
SELECT T.Date,D.TheFirstOfMonth, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
CII.Index_cons,FORMAT((CII.Index_cons-LAG (CII.Index_cons) 
OVER(ORDER BY T.Date ))/LAG (CII.Index_cons) 
OVER(ORDER BY T.Date),'P') AS DIFF
FROM [dbo].[TLV_125] T LEFT JOIN [dbo].[DateDimension]D
ON T.Date = D.TheDate
 LEFT JOIN [dbo].[Consumer_Price_Index_USA] CII
ON  D.TheFirstOfMonth= CII.Start_Date 
) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.TheFirstOfMonth  )
FROM THIS_TABLE T
ORDER BY T.Date 



-- שינוי ריבית בישראל

WITH THIS_TABLE AS(
SELECT T.Date,D.TheLastOfMonth, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
CII.Index_cons,FORMAT((CII.Index_cons-LAG (CII.Index_cons) 
OVER(ORDER BY T.Date ))/LAG (CII.Index_cons) 
OVER(ORDER BY T.Date),'P') AS DIFF
FROM [dbo].[TLV_125] T LEFT JOIN [dbo].[DateDimension]D
ON T.Date = D.TheDate
 LEFT JOIN [dbo].[Interest_rate_Isreal] CII
ON  D.TheLastOfMonth= CII.End_Date 
) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.TheLastOfMonth  )
FROM THIS_TABLE T
ORDER BY T.Date 

-- לחזור לזה 

SELECT *
FROM [dbo].[US_Interest]


SELECT I.War_Name,I.Start_Time,I.End_Time ,D.TheDate,I2.War_Name,I2.End_Time
FROM [dbo].[Isreal_Wars] I RIGHT JOIN   [dbo].[DateDimension] D
ON I.Start_Time = D.TheDate LEFT JOIN [dbo].[Isreal_Wars] I2 ON 
D.TheDate = I2.End_Time
WHERE I.Start_Time IS NOT NULL OR I2.End_Time IS NOT NULL


--שינוי הטבלה לפי תאריכים של מלחמות בישראל
CREATE VIEW WAR_TABLE AS 
SELECT D.TheDate,CASE WHEN D.TheDate>='1990-08-02' AND D.TheDate<='1991-02-28' THEN 'Gulf War'
WHEN D.TheDate>='1993-07-25' AND D.TheDate<='1993-07-31' THEN 'Operation Accountability'
WHEN D.TheDate>='2006-07-12' AND D.TheDate<='2006-08-14' THEN 'The second Lebanon war'
WHEN D.TheDate>='2008-12-27' AND D.TheDate<='2009-01-18' THEN 'Operation Cast Lead'
WHEN D.TheDate>='2012-11-14' AND D.TheDate<='2012-11-21' THEN 'Operation Pillar of Defense'
WHEN D.TheDate>='2014-07-08' AND D.TheDate<='2014-08-26' THEN 'Operation Protective Edge'END AS WAR
FROM [dbo].[Isreal_Wars] I RIGHT JOIN   [dbo].[DateDimension] D
ON I.Start_Time = D.TheDate LEFT JOIN [dbo].[Isreal_Wars] I2 ON 
D.TheDate = I2.End_Time

-- מלחמות בישראל מול התאריכים
WITH THIS_TABLE AS(
SELECT T.Date,D.TheLastOfMonth, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
W.WAR
FROM [dbo].[TLV_125] T LEFT JOIN [dbo].[DateDimension]D
ON T.Date = D.TheDate
 LEFT JOIN WAR_TABLE W
ON  D.TheDate = W.TheDate
) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.TheLastOfMonth  )
FROM THIS_TABLE T
ORDER BY T.Date 


-- מכל המחלות בעולם בחירה של מחלות ברמה עולמית ושהמתים הם יותר מ1000
select *
from [dbo].[Global_Disease_Years]
where [Location]= 'worldwide' and [Death_toll_estimate]>1000

-- כתיבה ידנית לפי התאריכים של המחלות  
ALTER VIEW Global_pandemic AS 
WITH THIS_TABLE AS(
SELECT D.TheDate,CASE WHEN D.TheDate>='2009-01-01' AND D.TheDate<=EOMONTH('2010-12-01') THEN '2009 swine flu pandemic'
WHEN D.TheDate>='2019-01-01'  THEN 'COVID-19 pandemic'
WHEN D.TheDate>='2002-01-01' AND D.TheDate<=EOMONTH('2004-12-01') THEN '2002–2004 SARS outbreak' 
END pandemic
FROM [dbo].[DateDimension] D)
SELECT T.*,GD.*
FROM THIS_TABLE T JOIN [dbo].[Global_Disease_Years] GD
ON T.pandemic = GD.Event


-- חיבור של מחלות לתאריכם וכמות מתים
WITH THIS_TABLE AS(
SELECT T.Date,D.TheFirstOfMonth,D.TheFirstOfQuarter, T.Closing_index,T.Closing_index-LAG(T.Closing_index) 
OVER(ORDER BY T.Date) DIFF_IN_POINTS, FORMAT((T.Closing_index-LAG (T.Closing_index)
OVER(ORDER BY T.Date))  /LAG (T.Closing_index)
OVER(ORDER BY T.Date),'P') PRSE_CHANGE, 
G.pandemic,G.Death_toll_estimate
FROM [dbo].[TLV_125] T LEFT JOIN [dbo].[DateDimension]D
ON T.Date = D.TheDate
 LEFT JOIN Global_pandemic G
ON  D.TheDate = G.TheDate
) 
SELECT T.*, SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY YEAR(DATE)  ), 
SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.TheFirstOfMonth),
SUM(T.DIFF_IN_POINTS) OVER (PARTITION BY T.TheFirstOfQuarter)
FROM THIS_TABLE T
ORDER BY T.Date 

-- חיבור של מלחמות לתאריכים
SELECT D.TheDate,W.Name_of_Conflict,W2.Name_of_Conflict,
CASE WHEN D.TheDate BETWEEN W.[Start_Date] AND W.[Finish_Date]
THEN 1 END
FROM [dbo].[War_WorldWide] W RIGHT JOIN  [dbo].[DateDimension]D
ON W.Start_Date = D.TheDate  LEFT JOIN [dbo].[War_WorldWide] W2
ON W2.Finish_Date =D.TheDate
WHERE D.TheDate BETWEEN '2000-01-06' AND '2022-04-07' 
ORDER BY D.TheDate

-- לבנות בטרנזקס SQL
select *
from [dbo].[US_Interest]-[dbo].[War_WorldWide]

CREATE VIEW WD AS
select *
FROM [dbo].[War_WorldWide] W RIGHT JOIN  [dbo].[DateDimension]D
ON W.Start_Date = D.TheDate 

SELECT *
FROM [dbo].[DateDimension]

USE WD
GO

DECLARE @ STARTDATE date 
SELECT @STARTDATE= (SELECT[Start_Date] FROM  [War_WorldWide].[Start_Date])
WHILE ( @DATE <= [dbo].[War_WorldWide].[Finish_Date])
BEGIN
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    SET @Counter  = @Counter  + 1
END

