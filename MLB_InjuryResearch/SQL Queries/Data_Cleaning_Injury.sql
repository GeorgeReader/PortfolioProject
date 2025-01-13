-------------------DATA CLEANING MLB INJURY PROJECT------------------------
------ Excel Data Cleaning
--- Remove Dupliantine PitchMovement 1 value of 8936 unquie values
--- Remove Dupliantine PitchMovement 3 value of 1952 unquie values
--- =IF(ISNUMBER(D2), D2, DATE(VALUE("20" & RIGHT(D2, 2)), MONTH(1 & LEFT(D2, LEN(D2)-4)), 1))

--------------SELECT INJURYREPORT TABLE-----------------------------------

SELECT *
FROM PitchingData.dbo.InjuryReport


-------------REMOVE ALL POSITION PLAYERS FROM DATASET--------------------------

SELECT DISTINCT Position
FROM InjuryReport

DELETE FROM InjuryReport
WHERE Position IN('SS','OF/INF','1B/OF','UTL','INF','OF','DH','C/OF','1B','OF/1B',
				'1B/3B','INF/OF','2B', '2B/OF', '3B/1B','C/1B','3B','C','3B/OF','C/INF');

----- Delete 1815 rows

---------------TRANSFORM SP/RP AND RP/SP TO SP AND RP----------------------

UPDATE InjuryReport
SET Position = 
    CASE
        WHEN Position = 'SP/RP' THEN 'SP'
        WHEN Position = 'RP/SP' THEN 'RP'
        ELSE Position
    END;

------ Updated 2549 rows 

-----------------INJURY DATES FROM DATETIME TO DATE-------------------------

SELECT 
	CAST([Injury/Surgery_Date] AS DATE) AS [Injury/Surgery_Date],
	CAST(IL_RetroDate AS DATE) AS IL_RetroDate,
	CAST(Eligible_to_Return AS DATE) AS Eligible_to_Return,
	CAST(Return_Date AS DATE) AS Return_Date
FROM PitchingData.dbo.InjuryReport

----------------GROUP BODILY INJURY AND SEVERITY FROM INJURY/SURGERY-----------------------

SELECT Distinct [Injury / Surgery]
FROM PitchingData.dbo.InjuryReport

---- List of 457 Bodily Injuries and Surgeries

----Create Column of grouping parts of the body being treated --------------------

ALTER TABLE PitchingData.dbo.InjuryReport
ADD Injury_Grouping VARCHAR(255);

----- Process of Order and Grouping Injury / Surgery column in listing out type ------------

SELECT Distinct [Injury / Surgery], Injury_Grouping
FROM PitchingData.dbo.InjuryReport
--- WHERE Injury_Grouping = 'Other'

------ Insert data into Injury_Grouping column -------------------------------

UPDATE PitchingData.dbo.InjuryReport
SET Injury_Grouping = 
    CASE
--------------- Head and Body Injuries ------------
		WHEN [Injury / Surgery] LIKE '%teres major%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%intercostal%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%rib%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%Lat%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%Side%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%Oblique%' THEN 'Side'
		WHEN [Injury / Surgery] LIKE '%Abdom%' THEN 'Abdominal'
		WHEN [Injury / Surgery] LIKE '%Kidney%' THEN 'Abdominal'
		WHEN [Injury / Surgery] LIKE '%chest%' THEN 'Chest'
		WHEN [Injury / Surgery] LIKE '%Patellar%' THEN 'Chest'
		WHEN [Injury / Surgery] LIKE '%Pectoral%' THEN 'Chest'
		WHEN [Injury / Surgery] LIKE '%SC joint%' THEN 'Chest'
		WHEN [Injury / Surgery] LIKE '%lung%' THEN 'Chest'
		WHEN [Injury / Surgery] LIKE '%spine%' THEN 'Back'
		WHEN [Injury / Surgery] LIKE '%Back%' THEN 'Back'
		WHEN [Injury / Surgery] LIKE '%lumbar%' THEN 'Back'
		WHEN [Injury / Surgery] LIKE '%thoracic%' THEN 'Back'
		WHEN [Injury / Surgery] LIKE '%cervical%' THEN 'Back'
		WHEN [Injury / Surgery] LIKE '%Fac%' THEN 'Face'
		WHEN [Injury / Surgery] LIKE '%Skull%' THEN 'Face'
		WHEN [Injury / Surgery] LIKE '%nose%' THEN 'Face'
		WHEN [Injury / Surgery] LIKE '%Concussion%' THEN 'Face'
		WHEN [Injury / Surgery] LIKE '%Nasal%' THEN 'Face'
		WHEN [Injury / Surgery] LIKE '%Neck%' THEN 'Neck'
		WHEN [Injury / Surgery] LIKE '%Hip%' THEN 'Hip'
		WHEN [Injury / Surgery] LIKE '%SI joint%' THEN 'Hip'
		WHEN [Injury / Surgery] LIKE '%glute%' THEN 'Hip'
		WHEN [Injury / Surgery] LIKE '%groin%' THEN 'Groin'
		WHEN [Injury / Surgery] LIKE '%testicular%' THEN 'Groin'
		WHEN [Injury / Surgery] LIKE '%Ulcerative%' THEN 'Groin'
------- Grouping Arm Injuries -----------------------------------
		WHEN [Injury / Surgery] LIKE '%Tommy John%' THEN 'Tommy John'
		WHEN [Injury / Surgery] LIKE '%Biceps%' THEN 'Biceps'
		WHEN [Injury / Surgery] LIKE '%Elbow%' THEN 'Elbow'
		WHEN [Injury / Surgery] LIKE '%Forearm%' THEN 'Forearm'
		WHEN [Injury / Surgery] LIKE '%Ulnar%' THEN 'Forearm'
		WHEN [Injury / Surgery] LIKE '%finger%' THEN 'Hand'
		WHEN [Injury / Surgery] LIKE '%flexor%' THEN 'Hand'
		WHEN [Injury / Surgery] LIKE '%hand%' THEN 'Hand'
		WHEN [Injury / Surgery] LIKE '%thumb%' THEN 'Hand'
		WHEN [Injury / Surgery] LIKE '%Shoulder%' THEN 'Shoulder'
		WHEN [Injury / Surgery] LIKE '%ac joint%' THEN 'Shoulder'
		WHEN [Injury / Surgery] LIKE '%Rotator cuff%' THEN 'Shoulder'
		WHEN [Injury / Surgery] LIKE '%triceps%' THEN 'Triceps'
		WHEN [Injury / Surgery] LIKE '%Carpal tunnel%' THEN 'Wrist'
		WHEN [Injury / Surgery] LIKE '%wrist%' THEN 'Wrist'
		WHEN [Injury / Surgery] LIKE '%arm%' THEN 'Arm'
---------- Grouping Leg Injuries ----------------------------------
		WHEN [Injury / Surgery] LIKE '%adductor%' THEN 'Upper Leg'
		WHEN [Injury / Surgery] LIKE '%Hamstring%' THEN 'Upper Leg'
		WHEN [Injury / Surgery] LIKE '%thigh%' THEN 'Upper Leg'
		WHEN [Injury / Surgery] LIKE '%quad%' THEN 'Upper Leg'
		WHEN [Injury / Surgery] LIKE '%tibia%' THEN 'Lower Leg'
		WHEN [Injury / Surgery] LIKE '%Calf%' THEN 'Lower Leg'
		WHEN [Injury / Surgery] LIKE '%Shin%' THEN 'Lower Leg'
		WHEN [Injury / Surgery] LIKE '%Achilles%' THEN 'Lower Leg'
		WHEN [Injury / Surgery] LIKE '%Leg%' THEN 'Leg'
		WHEN [Injury / Surgery] LIKE '%fascitis%' THEN 'Leg'
		WHEN [Injury / Surgery] LIKE '%Knee%' THEN 'Knee'
		WHEN [Injury / Surgery] LIKE '%Ankle%' THEN 'Ankle'
		WHEN [Injury / Surgery] LIKE '%Foot%' THEN 'Foot'
		WHEN [Injury / Surgery] LIKE '%toe%' THEN 'Foot'
		WHEN [Injury / Surgery] LIKE '%Blister%' THEN 'Foot'
------------ Grouping Sickness/ Illness ------------------------------
        WHEN [Injury / Surgery] LIKE '%Covid%' THEN 'Illness'
		WHEN [Injury / Surgery] LIKE '%Flu%' THEN 'Illness'
		WHEN [Injury / Surgery] LIKE '%Illness%' THEN 'Illness'	
		WHEN [Injury / Surgery] LIKE '%Appendicitis%' THEN 'Illness'
		WHEN [Injury / Surgery] LIKE '%Gastroenteritis%' THEN 'Illness'
		WHEN [Injury / Surgery] LIKE '%Mononucleosis%' THEN 'Illness'
		WHEN [Injury / Surgery] LIKE '%Viral infection%' THEN 'Illness'
        ELSE 'Other'
    END;

SELECT Distinct Injury_Grouping
FROM PitchingData.dbo.InjuryReport

---- Final result cased helps narrows all 457 types of injuries down to 25 grouping of the body.
---- Injury_Grouping help identify were most pitchers are getting injuried

--------CREATE COLUMN OF SEVERITY OF INJURY/ ILLNESS BEING TREATED

ALTER TABLE PitchingData.dbo.InjuryReport
ADD Injury_Severity VARCHAR(255);

----- Process of Order and Severity Injury / Surgery column in listing out levls ------------

SELECT Distinct [Injury / Surgery], Injury_Severity
FROM PitchingData.dbo.InjuryReport
---- WHERE Injury_Severity = 'Other'
---- WHERE Injury_Severity = 'Strain'


SELECT Distinct Injury_Severity, COUNT(*) as CountPlayers
FROM PitchingData.dbo.InjuryReport
GROUP BY Injury_Severity
ORDER BY CountPlayers DESC

---- GROUP BODY / FACE INJURIES

UPDATE PitchingData.dbo.InjuryReport
SET Injury_Severity = 
    CASE       
	------------ Sore and Minor Bodily Injury ----------------------------
		WHEN [Injury / Surgery] LIKE '%soreness%' THEN 'Sore'
		WHEN [Injury / Surgery] LIKE '%tightness%' THEN 'Sore'
		WHEN [Injury / Surgery] LIKE '%stiffness%' THEN 'Sore'
		WHEN [Injury / Surgery] LIKE '%discomfort%' THEN 'Sore'
		WHEN [Injury / Surgery] LIKE '%sprain%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%inflammation%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%Blister%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%Stress reaction%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%tendinitis%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%tendonitis%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%contusion%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%tuff toe%' THEN 'Minor'
		WHEN [Injury / Surgery] LIKE '%finger%' THEN 'Minor'
	----------------- Moderate Bodily injury -------------------
		WHEN [Injury / Surgery] LIKE '%torn%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%knee%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%elbow%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%dislocate%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%laceration%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%impingement%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%infection%' THEN 'Moderate'
----------- Split Strain injuries into Minor an Moderate levels ------------
		WHEN [Injury / Surgery] LIKE '%Strained back%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained hip%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained neck%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained upper back%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained lower back%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained shoulder%' THEN 'Moderate'
		WHEN [Injury / Surgery] LIKE '%Strained%' THEN 'Minor'
-------------- Major and Surgical Bodily Injury ----------------------------
		WHEN [Injury / Surgery] LIKE '%fracture%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%broken%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%spine%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%back%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%spasm%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%fatigue%' THEN 'Major'
		WHEN [Injury / Surgery] LIKE '%nerve%' THEN 'Major'
        WHEN [Injury / Surgery] LIKE '%surgery%' THEN 'Surgical'
		ELSE 'Undisclosed'
    END;

	SELECT Distinct Injury_Severity
FROM PitchingData.dbo.InjuryReport

---- Final result cased helps narrows all 457 types of injuries down to 6 levels of seriousness of injury.
---- Injury_Severity help identify how serious pitcher's injury it is and how they treat it.

ALTER TABLE PitchingData.dbo.InjuryReport
ADD Injury_Count FLOAT;

WITH PlayerCounts AS (
    SELECT Player, 
        COUNT(*) AS Injury_Count
    FROM PitchingData.dbo.InjuryReport
    WHERE injury_Grouping NOT IN ('Illness', 'Other')  -- Exclude 'Illness' and 'Other'
    GROUP BY Player
)
UPDATE ir
SET ir.Injury_Count = pc.Injury_Count
FROM PitchingData.dbo.InjuryReport ir
JOIN PlayerCounts pc ON ir.Player = pc.Player
WHERE ir.injury_Grouping NOT IN ('Illness', 'Other');  -- Ensure we only update relevant rows

------------------------SELECTING PITCH STATISTICS TABLE-------------------------------

----- Flipping Pitcher names in data tables to Match InjuryReport and PitchRoster
----- PitchArsenal names
SELECT *
FROM PitchingData.dbo.PitchArsenal

ALTER TABLE PitchingData.dbo.PitchArsenal
ADD Player VARCHAR(255);

UPDATE PitchingData.dbo.PitchArsenal
SET Player = CONCAT(
    LTRIM(RTRIM(SUBSTRING(Pitcher, CHARINDEX(',', Pitcher) + 1, LEN(Pitcher)))), ' ',
    LTRIM(RTRIM(SUBSTRING(Pitcher, 1, CHARINDEX(',', Pitcher) - 1))))

ALTER TABLE PitchingData.dbo.PitchArsenal
DROP COLUMN Pitcher, Rk#

----- PitchMovement names
SELECT *
FROM PitchingData.dbo.PitchMovement

ALTER TABLE PitchingData.dbo.PitchMovement
ADD Player VARCHAR(255);

UPDATE PitchingData.dbo.PitchMovement
SET Player = CONCAT(
    LTRIM(RTRIM(SUBSTRING(Pitcher, CHARINDEX(',', Pitcher) + 1, LEN(Pitcher)))), '',
    LTRIM(RTRIM(SUBSTRING(Pitcher, 1, CHARINDEX(',', Pitcher) - 1))))

ALTER TABLE PitchingData.dbo.PitchMovement
DROP COLUMN Pitcher, Rk#

----- PitchTempo names
SELECT *
FROM PitchingData.dbo.PitchTempo

ALTER TABLE PitchingData.dbo.PitchTempo
ADD Player2 VARCHAR(255);

UPDATE PitchingData.dbo.PitchTempo
SET Player2 = CONCAT(
    LTRIM(RTRIM(SUBSTRING(Player, CHARINDEX(',', Player) + 1, LEN(Player)))), ' ',
    LTRIM(RTRIM(SUBSTRING(Player, 1, CHARINDEX(',', Player) - 1))))

ALTER TABLE PitchingData.dbo.PitchTempo
DROP COLUMN Player, Rk#
-- RENAME Player2 to just Player


SELECT *
FROM PitchingData.dbo.PitchRoster

-------------------------------

------ ADD COLUMN SHOWCASING PITCHES PER GAME BASET

ALTER TABLE PitchingData.dbo.PitchRoster
ADD PPG FLOAT;

UPDATE PitchingData.dbo.PitchRoster
SET PPG = 
    CASE 
        WHEN G <> 0 THEN ROUND(CAST(Pitches AS DECIMAL(10, 1)) / CAST(G AS DECIMAL(10, 1)), 1)
        ELSE 0 -- or NULL, depending on your preference
    END;