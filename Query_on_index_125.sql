
--אחוז שינוי יומי בין פתיחה לסגירה
CREATE VIEW TLV_125__CHANG AS
SELECT  t.Date ,ROUND(t.Opening_index,2)as Opening_index, ROUND(t.Closing_index,2) as Closing_index , 
ROUND((t.Closing_index-t.Opening_index),2) as change_from_opening,
FORMAT((((t.Closing_index-t.Opening_index)/t.Opening_index)),'P')
as precent_changing_from_open
FROM [dbo].[TLV_125] t
;

-- קנייה ביום הראשון שמופיע ומכירה בכל יום אחר עד 7.4.2022
SELECT TLV.* , FORMAT((TLV.Closing_index - (SELECT T.Opening_index FROM TLV_125_CHANG  T WHERE T.DATE ='2000-01-03' ))
/(SELECT TL.Opening_index FROM TLV_125_CHANG TL WHERE TL.DATE ='2000-01-03' ),'P') AS Precent_Change_From_Begining,
(TLV.Closing_index - (SELECT T.Opening_index FROM TLV_125_CHANG  T WHERE T.DATE ='2000-01-03' )) AS Change_From_Begining
FROM TLV_125_CHANG TLV
ORDER BY TLV.DATE DESC



-- סה"כ שינוי בסכום  מפתיחה 
WITH TLV_125_CHANG AS
(SELECT  t.Date ,ROUND(t.Opening_index,2)as Opening_index, ROUND(t.Closing_index,2) as Closing_index , 
ROUND((t.Closing_index-t.Opening_index),2) as change_from_opening,
FORMAT((((t.Closing_index-t.Opening_index)/t.Opening_index)),'P')
as precent_changing_from_open
FROM [dbo].[TLV_125] t
)
SELECT
SUM(tl.change_from_opening) 
FROM TLV_125_CHANG AS tl


--קנייה ת מכירה בקצוות
;WITH CHANGR_FROM_PD AS(
SELECT t.Date,T.Base_index,T.Closing_index,T.Opening_index,t.Closing_index - LAG(t.Closing_index)
    OVER (ORDER BY t.Date ) AS difference_previous_day 
FROM TLV_125 t) 
SELECT CPD.*,ROUND(SUM(CPD.difference_previous_day) OVER
(ORDER BY CPD.Date  ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING),2) AS Diff_pre_Cumu,
FORMAT (ROUND(SUM(CPD.difference_previous_day) OVER
(ORDER BY CPD.Date ROWS  BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING),2)/CPD.Closing_index,'P') AS profit 
FROM CHANGR_FROM_PD CPD
ORDER  BY  CPD.Date DESC  


