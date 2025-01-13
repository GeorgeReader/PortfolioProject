Select *
From dbo.Data_Professional_Survey

--DATA_PROFESSIONAL_SURVEY BASIC ANAYTICS

  
--- Participants in Survey

Select COUNT(*) as Survey_Participants
FROM dbo.Data_Professional_Survey

--- Average Age of Participants

SELECT 
	AVG([Q10 - Current Age]) as AVG_Age
FROM dbo.Data_Professional_Survey

--- Dates of Surveys Taken

SELECT [Date Taken (America/New_York)] as Date_Taken
FROM dbo.Data_Professional_Survey
WHERE CONVERT(date, [Date Taken (America/New_York)]) BETWEEN '2022-06-10' AND '2022-06-26'
ORDER BY CONVERT(date, [Date Taken (America/New_York)]);


--------------------------------------------------------------------------------------------------------------------------
-- Count of Participants that switch careers into Data


SELECT [Q2 - Did you switch careers into Data?] as Career_Change,
	COUNT ([Q2 - Did you switch careers into Data?]) as Count
FROM dbo.Data_Professional_Survey
GROUP BY [Q2 - Did you switch careers into Data?];

-----------------------------------------------------------------------------------------------------------

--- Participants Current Working Role

Select
    CASE 
        WHEN [Q1 - Which Title Best Fits your Current Role?] like '%Other%' THEN 'Other'
        ELSE [Q1 - Which Title Best Fits your Current Role?]
    END AS Current_Role,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q1 - Which Title Best Fits your Current Role?] like '%Other%' THEN 'Other'
        ELSE [Q1 - Which Title Best Fits your Current Role?]
    END
Order by Count Desc;

--- Salaries of Participants in Job Title

	SELECT 
    t.CurrentRole,
    t.CurrentSalary,
    COUNT(*) AS Count
FROM (
    SELECT 
        CASE 
            WHEN [Q1 - Which Title Best Fits your Current Role?] like '%Other%' THEN 'Other'
            ELSE [Q1 - Which Title Best Fits your Current Role?]
        END AS CurrentRole, 
        [Q3 - Current Yearly Salary (in USD)] AS CurrentSalary
    FROM dbo.Data_Professional_Survey
) AS t
GROUP BY 
    t.CurrentRole,
    t.CurrentSalary
ORDER BY 
    t.CurrentSalary, Count Desc;

----------------------------------------------------------------------------------------------------------------

--- Participants Current Yearly Salary

Select [Q3 - Current Yearly Salary (in USD)] as Current_Salary,
	COUNT([Q3 - Current Yearly Salary (in USD)]) as Count
	FROM dbo.Data_Professional_Survey
	GROUP BY [Q3 - Current Yearly Salary (in USD)]
	Order by Count Desc;

----------------------------------------------------------------------------------------------------------------

--- Industries Participants Work in

SELECT
    CASE 
        WHEN [Q4 - What Industry do you work in?] like '%Other%' THEN 'Other'
        ELSE [Q4 - What Industry do you work in?]
    END AS Industry,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q4 - What Industry do you work in?] like '%Other%' THEN 'Other'
        ELSE [Q4 - What Industry do you work in?]
    END
Order by Count Desc;

-----------------------------------------------------------------------------------------------------

--SURVEY QUESTION ON Favorite Programming

Select
    CASE 
        WHEN [Q5 - Favorite Programming Language] like '%Other%' THEN 'Other'
        ELSE [Q5 - Favorite Programming Language]
    END AS Fav_Program,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q5 - Favorite Programming Language] like '%Other%' THEN 'Other'
        ELSE [Q5 - Favorite Programming Language]
    END
Order by Count Desc;

-- Look at How many Participants picked SQL as Favorite Programming Language

SELECT 
    CASE 
        WHEN [Q5 - Favorite Programming Language] LIKE '%SQL%' THEN 'SQL'
        ELSE 'Other'
    END AS FAV_Program,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q5 - Favorite Programming Language] LIKE '%SQL%' THEN 'SQL'
        ELSE 'Other'
    END;

----------------------------------------------------------------------------------------------------------------

--- Participants Current Yearly Salary BY Generation

SELECT 
    t.CurrentSalary,
	t.Generation,
    COUNT(*) AS Count
FROM (	
    SELECT
        CASE 
            WHEN [Q10 - Current Age] <= 23 THEN 'Generation Z'
            WHEN [Q10 - Current Age] BETWEEN 24 AND 43 THEN 'Millennials'
            WHEN [Q10 - Current Age] BETWEEN 44 AND 59 THEN 'Generation X'
            WHEN [Q10 - Current Age] >= 60 THEN 'Baby_Boomer'
        END AS Generation,
        [Q3 - Current Yearly Salary (in USD)] AS CurrentSalary
    FROM dbo.Data_Professional_Survey
) AS t
GROUP BY 
      t.CurrentSalary,
	t.Generation
ORDER BY 
    t.CurrentSalary, Count DESC;
---------------------------------------------------------------------------------------------------------------

----Survey Questionnaire Rating their Happiness with work life From 1 to 10

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the followi] AS FLOAT)) AS Happy_Salary
FROM dbo.Data_Professional_Survey; 

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the follow1] AS FLOAT)) AS HappyWork_LifeBalance
FROM dbo.Data_Professional_Survey; 

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the follow2] AS FLOAT)) AS Happy_Coworkers
FROM dbo.Data_Professional_Survey; 

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the follow3] AS FLOAT)) AS Happy_Management
FROM dbo.Data_Professional_Survey; 

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the follow4] AS FLOAT)) AS Happy_Upward_Mobility
FROM dbo.Data_Professional_Survey; 

SELECT 
   AVG(CAST([Q6 - How Happy are you in your Current Position with the follow5] AS FLOAT)) AS  Happy_Learning_NewThings
FROM dbo.Data_Professional_Survey; 

--------------------------------------------------------------------------------------------------------------------------------------

------ SURVEY QUESTION ON How difficult was it for you to break into Data?


SELECT 
    [Q7 - How difficult was it for you to break into Data?] AS Difficulty_Data,
    COUNT([Q7 - How difficult was it for you to break into Data?]) AS Count,
    ROUND(100.0 * COUNT([Q7 - How difficult was it for you to break into Data?]) / SUM(COUNT([Q7 - How difficult was it for you to break into Data?])) OVER (), 2) AS Percentage
FROM dbo.Data_Professional_Survey
GROUP BY [Q7 - How difficult was it for you to break into Data?];

-------------------------------------------------------------------------------------------------------------------------

-- SURVEY QUESTION ON Participants Most Important Quality in New Job

SELECT
  CASE 
        WHEN [Q8 - If you were to look for a new job today, what would be the ] like '%Other%' THEN 'Other'
        ELSE [Q8 - If you were to look for a new job today, what would be the ]
    END AS NewJob_Want,
	COUNT(*) as Count
	FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q8 - If you were to look for a new job today, what would be the ] like '%Other%' THEN 'Other'
        ELSE [Q8 - If you were to look for a new job today, what would be the ]
    END
ORDER BY Count Desc;

------------------------------------------------------------------------------------------

-- SURVEY QUESTION ON How Difficulty by Gender in Break into Data Field

SELECT 
    [Q9 - Male/Female?] AS Gender, 
     [Q7 - How difficult was it for you to break into Data?] AS Difficulty_LVL,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY [Q9 - Male/Female?],  [Q7 - How difficult was it for you to break into Data?]
Order by [Q7 - How difficult was it for you to break into Data?] desc;


------------------------------------------------------------------------------------------

--- Count Participants by Gender in Survey

SELECT [Q9 - Male/Female?] as Gender,
	COUNT([Q9 - Male/Female?]) as Count
	FROM dbo.Data_Professional_Survey
	GROUP BY [Q9 - Male/Female?];

-- Gender Yearly Salary	Group

SELECT 
    [Q9 - Male/Female?] AS Gender, 
    [Q3 - Current Yearly Salary (in USD)] AS Yearly_Salary,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY [Q9 - Male/Female?], [Q3 - Current Yearly Salary (in USD)]
Order by [Q9 - Male/Female?] desc, Count Desc;

--------------------------------------------------------------------------------------------------------------------------------------

--- Countries of Survey Taken

Select 
  CASE 
        WHEN [Q11 - Which Country do you live in?] like '%Other%' THEN 'Other'
        ELSE [Q11 - Which Country do you live in?]
    END AS Country,
	COUNT(*) as Count
	FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q11 - Which Country do you live in?] like '%Other%' THEN 'Other'
        ELSE [Q11 - Which Country do you live in?]
    END
ORDER BY Count Desc;

-------------------------------------------------------------------------------------------------------------------------------------

--- Participants by Generation

SELECT
    CASE 
        WHEN [Q10 - Current Age] <= '23' THEN 'Generation Z'
        WHEN [Q10 - Current Age] BETWEEN 24 AND 43 THEN 'Millennials'
        WHEN [Q10 - Current Age] BETWEEN 44 AND 59 THEN 'Generation X'
        WHEN [Q10 - Current Age] >= '60' THEN 'Baby_Boomer'
    END AS Generation,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY
    CASE 
        WHEN [Q10 - Current Age] <= '23' THEN 'Generation Z'
        WHEN [Q10 - Current Age] BETWEEN 24 AND 43 THEN 'Millennials'
        WHEN [Q10 - Current Age] BETWEEN 44 AND 59 THEN 'Generation X'
        WHEN [Q10 - Current Age] >= '60' THEN 'Baby_Boomer'
    END;

-------------------------------------------------------------------------------------------------------------

--- Particicpants Level of Education 

SELECT 
	[Q12 - Highest Level of Education] AS Education,
    COUNT(*) AS Count
FROM dbo.Data_Professional_Survey
GROUP BY [Q12 - Highest Level of Education]
Order by Count Desc;


---------------------------------------------------------------------------------------------------

--- Ethnicity of Participants 

SELECT 
    CASE 
        WHEN [Q13 - Ethnicity] like '%Pacific Islander%' THEN 'Native Hawaiian Pacific Islander'
        WHEN [Q13 - Ethnicity] like '%Other%' THEN 'International/Mixed'
        ELSE [Q13 - Ethnicity]
    END AS Ethnicity,
    COUNT(*) AS Count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM dbo.Data_Professional_Survey
GROUP BY 
    CASE 
        WHEN [Q13 - Ethnicity] like '%Pacific Islander%' THEN 'Native Hawaiian Pacific Islander'
        WHEN [Q13 - Ethnicity] like '%Other%' THEN 'International/Mixed'
        ELSE [Q13 - Ethnicity]
    END
ORDER BY Count DESC;