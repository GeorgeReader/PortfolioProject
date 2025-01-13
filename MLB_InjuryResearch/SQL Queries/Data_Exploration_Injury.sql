
-------------DATA EXPLORATION OF PITCHING INJURIES AND RULTIES----------------

-------------------COUNT PITCHERS Injuries-----------------------------------------------------
-- Number of Pitchers
SELECT DISTINCT COUNT (Player) AS CountofInjuries
FROM PitchingData.dbo.InjuryReport
-- After data cleaning process there are 2546 pitchers accountanted for that end up on IL over the last 5 years

-- Count Pitchers by there Role 
SELECT Position, COUNT(*) AS CountofInjuriedPlayers,
(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM PitchingData.dbo.InjuryReport WHERE Position = InjuryReport.Position)) AS PosPercentage
FROM PitchingData.dbo.InjuryReport
GROUP BY Position
ORDER BY CountofInjuriedPlayers DESC
-- Most of the Pitchers injuries come from reliefs 1455 of the 2546 pitchers being 57 percent of the injuries

-- Teams that struggle with injuries
SELECT Team, COUNT(*) AS CountofInjuriedPlayers
FROM PitchingData.dbo.InjuryReport
GROUP BY Team
ORDER BY CountofInjuriedPlayers DESC;
-- The two teams that have most pitching injuries are LA Dodgers and Tampa Bay Rays
------------------------------------------------------------------------------------------------

-- Most popular type of injury
SELECT [Injury / Surgery], COUNT(*) AS CountofInjuries
FROM PitchingData.dbo.InjuryReport
GROUP BY [Injury / Surgery]
ORDER BY CountofInjuries DESC
-- Tommy John surgery is the highest count of injury among pitchers

---- The most typical status amoung pitcher going on IL that are not reactivated
SELECT Status, COUNT(*) AS CountofInjuries
FROM PitchingData.dbo.InjuryReport
WHERE Status NOT IN ('Activated', 'Active Roster') 
GROUP BY Status
ORDER BY CountofInjuries DESC
-- Most Pitchers that were not reactivited to the roster got sent to the 60-Day IL to treat injury

---- Lastest updates amoung pitcher that went to IL that where not reactivated
SELECT [Latest Update], COUNT(*) AS CountofInjuries
FROM PitchingData.dbo.InjuryReport
-- WHERE [Latest Update] <> 'Activated' 
GROUP BY [Latest Update]
ORDER BY CountofInjuries DESC
---- The players that where not reactivated was split between out for the season questionable and rehab
---- In grouping this update values will give better result showing were players are at with there injury

---- Lastest updates amoung pitcher that went to IL that where not reactivated and group update
SELECT 
    CASE 
        WHEN [Latest Update] LIKE '%Out for%' THEN 'Out for the Season'
        WHEN [Latest Update] LIKE '%Rehab%' THEN 'Rehab Assignment'
        WHEN [Latest Update] LIKE '%Questionable%' THEN 'Questionable'
        WHEN [Latest Update] LIKE '%Doubtful%' THEN 'Doubtful'
		WHEN [Latest Update] LIKE '%Will return%' THEN 'Will Return'
		ELSE 'No timetable for return'
    END AS InjuryStatus,
    COUNT(*) AS CountofInjuries
FROM PitchingData.dbo.InjuryReport
WHERE [Latest Update] <> 'Activated' 
GROUP BY 
    CASE 
        WHEN [Latest Update] LIKE '%Out for%' THEN 'Out for the Season'
        WHEN [Latest Update] LIKE '%Rehab%' THEN 'Rehab Assignment'
        WHEN [Latest Update] LIKE '%Questionable%' THEN 'Questionable'
        WHEN [Latest Update] LIKE '%Doubtful%' THEN 'Doubtful'
		WHEN [Latest Update] LIKE '%Will return%' THEN 'Will Return'
		ELSE 'No timetable for return'
    END 
ORDER BY CountofInjuries DESC;
---- This result shows that most of pitchers that where not reactivated were shut down for the season

-----------------------------------------------------------------------------------------------------
-------------------COUNT DISTINCT PITCHERS ARSENAL---------------------------------------------------

SELECT COUNT(DISTINCT Player)AS '4-Seamer Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where [4-Seamer] is not Null

SELECT COUNT (DISTINCT Player)AS 'Sinker Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Sinker is not Null

SELECT COUNT (DISTINCT Player)AS 'Cutter Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Cutter is not Null

SELECT COUNT (DISTINCT Player)AS 'Slider Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Slider is not Null

SELECT COUNT (DISTINCT Player)AS 'Changeup Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Changeup is not Null

SELECT COUNT (DISTINCT Player)AS 'Curve Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Curve is not Null

SELECT COUNT (DISTINCT Player)AS 'Splitter Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Splitter is not Null

SELECT COUNT (DISTINCT Player)AS 'Sweeper Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Sweeper is not Null

SELECT COUNT (DISTINCT Player)AS 'Slurve Pitchers'
FROM PitchingData.dbo.PitchArsenal
Where Slurve is not Null

-----------------------------------------------------------------------------------------------
---------4-Seamers	 Sinker	   Cutter	Slider	Changeup	Curve	Splitter    Sweeper	  Slurve
--COUNT		1365	  1034		576		 1166	  1134		 877	  182		  343		19

--------------PITCH SPEED OF FASTBALL, SLIDER, AND CHANGEUP-------------------------------------------

SELECT Player, [4-Seamer]
FROM PitchingData.dbo.PitchArsenal
ORDER BY [4-Seamer] DESC;
--- Top Fastest 4-Seamers Jhoan Duran, Ben Joyce, and Mason Miller

SELECT Player, Slider
FROM PitchingData.dbo.PitchArsenal
ORDER BY Slider DESC
--- Top Fastest Sliders Dillon Tate, Sam Coonrod, and Jacob deGrom

SELECT Player, Changeup
FROM PitchingData.dbo.PitchArsenal
ORDER BY Changeup DESC
--- Top Fastest SChangeups Pete Fairbanks, Yerry De Los Santos, and Edwin Díaz
------------------------------------------------------------------------

SELECT *
FROM PitchingData.dbo.PitchTempo

----- The changeing Tempo by pitchers prior time clock and currently
SELECT AVG(BasesEmpty_Tempo) AS 'AVG_BasesEmpty_Tempo', AVG(RunnersOn_Tempo) AS 'AVG_RunnersOn_Tempo'
FROM PitchingData.dbo.PitchTempo
WHERE Season BETWEEN 2020 AND 2022

SELECT AVG(BasesEmpty_Tempo) AS 'AVG_BasesEmpty_Tempo', AVG(RunnersOn_Tempo) AS 'AVG_RunnersOn_Tempo'
FROM PitchingData.dbo.PitchTempo
WHERE Season BETWEEN 2023 AND 2024
--- The Pitch Clock descreased Pitcher Tempo by average of 4 seconds 
--- BaseEmpty by 3 seconds and RunnersOn by 5 seconds

SELECT Player, BasesEmpty_Tempo
FROM PitchingData.dbo.PitchTempo
WHERE BasesEmpty_Pitches > 800
AND Season BETWEEN 2020 AND 2022
ORDER BY BasesEmpty_Tempo ASC

SELECT Player, BasesEmpty_Tempo
FROM PitchingData.dbo.PitchTempo
WHERE BasesEmpty_Pitches > 800
AND Season BETWEEN 2023 AND 2024
ORDER BY BasesEmpty_Tempo ASC

SELECT Player, RunnersOn_Tempo
FROM PitchingData.dbo.PitchTempo
WHERE RunnersOn_Pitches > 500
AND Season BETWEEN 2020 AND 2022
ORDER BY RunnersOn_Tempo ASC

SELECT Player, RunnersOn_Tempo
FROM PitchingData.dbo.PitchTempo
WHERE RunnersOn_Pitches > 500
AND Season BETWEEN 2023 AND 2024
ORDER BY RunnersOn_Tempo ASC


----------------------------------------------------------------------------------
-------------------PITCH MOVEMENT OF FASTBALL, SINKER, SLIDER, CHANGEUP, CURVE --------------------------------
SELECT *
FROM PitchingData.dbo.PitchMovement

---- The Most persist Fastball in the League that has low movement with high verlocity
SELECT Player, Pitch, Total_VertvsComp, Total_HorzvsComp
FROM PitchingData.dbo.PitchMovement
WHERE Pitch = '4-Seam Fastball'
AND MPH > 95 
AND Pitches > 500
AND Total_VertvsComp < 1 AND Total_VertvsComp > -1
AND Total_HorzvsComp < 1 AND Total_HorzvsComp > -1
ORDER BY MPH DESC
--- Top  4-Seamers Jacob deGrom, Bobby Miller, and Zack Wheeler

---- The Most effective Sinker in the League that has high and most persis Vertical movement with high verlocity
SELECT Player, Pitch, Total_VertvsComp, Total_HorzvsComp
FROM PitchingData.dbo.PitchMovement
WHERE Pitch = 'Sinker'
AND MPH > 90 
AND Pitches > 500
AND Total_VertvsComp > 1 
AND Total_HorzvsComp < 1 AND Total_HorzvsComp > -1
ORDER BY MPH DESC
--- Top  Sinker Jordan Hicks, José Soriano, and Anthony Bender

---- The Most persist Changeup in the League that has small amount of movement with high verlocity
SELECT Player, Pitch, Total_VertvsComp, Total_HorzvsComp
FROM PitchingData.dbo.PitchMovement
WHERE Pitch = 'Changeup'
AND MPH > 80 
AND Pitches > 250
AND Total_VertvsComp < 2 AND Total_VertvsComp > -2
AND Total_HorzvsComp < 2 AND Total_HorzvsComp > -2
ORDER BY MPH DESC
--- Top  Changeup Edward Cabrera, Sandy Alcantara, and Luis Gil

---- The Most persist Curveball in the League that has most vertical movement
SELECT Player, Pitch, Total_VertvsComp, Total_HorzvsComp
FROM PitchingData.dbo.PitchMovement
WHERE Pitch = 'Curveball'
AND MPH > 80 
AND Pitches > 250
AND Total_VertvsComp > 1
AND Total_HorzvsComp < 2 AND Total_HorzvsComp > -2
ORDER BY Total_VertvsComp DESC
--- Top  Curveball Gerrit Cole, Shane Bieber, and Walker Buehler

---- The Most persist Slider in the League that has most vertical movement
SELECT Player, Pitch, Total_VertvsComp, Total_HorzvsComp
FROM PitchingData.dbo.PitchMovement
WHERE Pitch = 'Slider'
AND MPH > 85 
AND Pitches > 250
AND Total_VertvsComp < 2 AND Total_VertvsComp > -2
AND Total_HorzvsComp > 1
ORDER BY Total_HorzvsComp DESC
--- Top  Curveball Aroldis Chapman, Matt Brash, and Graham Ashcraft