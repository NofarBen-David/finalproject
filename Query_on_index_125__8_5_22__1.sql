﻿
--הוצאה רק של ימי ראשון מהטבלה 
CREATE VIEW ONLEY_1 AS 
SELECT T.Date,D.TheDayOfWeek,  T.Closing_index
FROM TLV_125 T LEFT JOIN DateDimension D
ON T.Date = D.TheDate
WHERE D.TheDayOfWeek = 1
;

--הוצאה רק של ימי ראשון וחמישי
ALTER VIEW ONLEY_2D AS
SELECT T.Date,D.TheDayOfWeek,  T.Closing_index
FROM TLV_125 T LEFT JOIN DateDimension D
ON T.Date = D.TheDate
WHERE D.TheDayOfWeek IN ( 1,5)


--קנייה ביום ראשון ומכירה ביום חמישי באותו שבוע 
CREATE VIEW BuyOn1SaleOn5 as
SELECT T.*,D.THEDAYOFWEEK,
CASE
    WHEN D.THEDAYOFWEEK =5 THEN( T.Closing_index - LAG(T.OPENING_INDEX) OVER (ORDER BY D.TheDate ) ) END AS difference_previous_day,
CASE WHEN D.THEDAYOFWEEK =5 THEN (FORMAT(((T.Closing_index / LAG(T.Closing_index) OVER (ORDER BY D.TheDate ))-1),'P')) END AS DIFF_IN_PRE
 FROM TLV_125 T RIGHT JOIN [dbo].[DateDimension] D
ON T.Date = D.TheDate
WHERE D.THEDAYOFWEEK IN ( 1,5) AND D.TheDate <'2022-04-07'AND D.TheDate >'2000-01-06'


--קנייה ביום חמישי ומכירה ביום ראשון של שבוע אחרי 
CREATE VIEW BuyOn5SaleOn1 as
SELECT T.*,D.THEDAYOFWEEK,
CASE
    WHEN D.THEDAYOFWEEK =1 THEN( T.Closing_index - LAG(T.OPENING_INDEX) OVER (ORDER BY D.TheDate ) ) END AS difference_previous_day,
CASE WHEN D.THEDAYOFWEEK =1 THEN (FORMAT(((T.Closing_index / LAG(T.Closing_index) OVER (ORDER BY D.TheDate ))-1),'P')) END AS DIFF_IN_PRE
 FROM TLV_125 T RIGHT JOIN [dbo].[DateDimension] D
ON T.Date = D.TheDate
WHERE D.THEDAYOFWEEK IN ( 1,5) AND D.TheDate <'2022-04-07'AND D.TheDate >'2000-01-06'





--המדד סגירה הכי גבוה באותו שבוע , לפי שבוע מלא בלבד
CREATE VIEW Max_index_week as
WITH MAX_INDEX_DAY AS(
SELECT  T.*,
     MAX(T.Closing_index) OVER (PARTITION BY  T.one_row) AS MAX_INDEX	
FROM ONLEY_3 T
)
SELECT M.Date,m.TheDayOfWeek,  M.Closing_index,O.THEDAYOFWEEK as TheMaxDay ,M.MAX_INDEX
FROM MAX_INDEX_DAY M  JOIN  ONLEY_3 O
ON M.MAX_INDEX = O.Closing_index




-- באיזה יום בשבוע המדד הכי נמוך
CREATE VIEW Min_index_week as
WITH MIN_INDEX_DAY AS(
SELECT  T.*,
     MIN(T.Closing_index) OVER (PARTITION BY  T.one_row) AS MIN_INDEX	
FROM ONLEY_3 T
)
SELECT M.Date,m.TheDayOfWeek,  M.Closing_index,O.THEDAYOFWEEK
as TheMinDay,M.MIN_INDEX
FROM MIN_INDEX_DAY M  JOIN  ONLEY_3 O
ON M.MIN_INDEX = O.Closing_index


--שליפה רק של שבועות מלאים מהטבלה 
CREATE VIEW ONLEY_3 AS
WITH COUNT_ONE AS(
SELECT D.TheDayOfWeek,T.*,D.THEWEEK+TheYear*1000 AS WEEK_YEAR,DENSE_RANK() OVER( ORDER BY D.THEWEEK+TheYear*1000) AS ONE_ROW
FROM TLV_125 T RIGHT JOIN [dbo].[DateDimension] D
ON T.Date = D.TheDate
WHERE T.DATE IS NOT NULL
 ),COUNT_ONE2 AS(
SELECT T.*, COUNT(ONE_ROW) OVER( PARTITION BY ONE_ROW ORDER BY ONE_ROW)ROW5
FROM COUNT_ONE T RIGHT JOIN [dbo].[DateDimension] D
ON T.Date = D.TheDate)
SELECT *
FROM COUNT_ONE2
WHERE ROW5 = 5;

--מכירה וקנייה בימים שונים באותו שבוע , איך משפיע על המחיר
SELECT O.DATE,O.THEDAYOFWEEK,O.OPENING_INDEX,O.CLOSING_INDEX,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,4) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,3) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =2 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
	ELSE (O.CLOSING_INDEX-O.OPENING_INDEX) END AS BUY_ON_1_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,3) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =1 THEN NULL 
	ELSE (O.CLOSING_INDEX-O.OPENING_INDEX) END AS BUY_ON_2_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN (O.CLOSING_INDEX-O.OPENING_INDEX) 
	ELSE NULL END AS BUY_ON_3_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN(O.CLOSING_INDEX-O.OPENING_INDEX) 
	ELSE NULL END AS BUY_ON_4_SALE_ON_THIS_DAY
	FROM ONLEY_3 O
	ORDER BY O.DATE DESC

	--כפולה של הטבלה השנייה 
	SELECT O.DATE,O.THEDAYOFWEEK,O.OPENING_INDEX,O.CLOSING_INDEX,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,4) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,3) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =2 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
	ELSE (O.CLOSING_INDEX-O.OPENING_INDEX) END AS BUY_ON_1_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,3) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =1 THEN NULL 
	ELSE (O.CLOSING_INDEX-O.OPENING_INDEX) END AS BUY_ON_2_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,2) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) ) 
    WHEN O.THEDAYOFWEEK =3 THEN (O.CLOSING_INDEX-O.OPENING_INDEX) 
	ELSE NULL END AS BUY_ON_3_SALE_ON_THIS_DAY,CASE
    WHEN O.THEDAYOFWEEK =5 THEN( O.Closing_index - LAG(O.OPENING_INDEX,1) OVER (ORDER BY O.Date ) )  
    WHEN O.THEDAYOFWEEK =4 THEN(O.CLOSING_INDEX-O.OPENING_INDEX) 
	ELSE NULL END AS BUY_ON_4_SALE_ON_THIS_DAY
	FROM ONLEY_3 O
	ORDER BY O.DATE DESC


	SELECT *
	FROM [dbo].[Global_Disease_Years]