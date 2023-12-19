-- Show the percentage of counties that have more
-- females than males.
-- 1.1 marks: <8 operators
-- 1.0 marks: <10 operators
-- 0.9 marks: <13 operators
-- 0.8 marks: correct answer


-- Replace this comment line with the actual query
SELECT (CountyWithMoreFemale/COUNT(fips)) AS 'Fraction'
FROM County, (
    SELECT COUNT(GB1.county) AS CountyWithMoreFemale
    FROM GenderBreakdown AS GB1
    JOIN GenderBreakdown AS GB2 ON (GB1.gender != GB2.gender AND GB1.county = GB2.county)
    WHERE GB1.gender = 'male' AND GB2.gender = 'female' AND GB2.population > GB1.population
) AS Table2
GROUP BY CountyWithMoreFemale;