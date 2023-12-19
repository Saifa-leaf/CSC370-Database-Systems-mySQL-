-- Out of those counties with at least 25000 residents,
-- retrieve the pair from the same state
-- that had the absolute closest
-- population in 2018
-- 1.1 marks: <11 operators
-- 1.0 marks: <12 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT C1.name, CP1.population, C2.name, CP2.population
FROM CountyPopulation AS CP1
JOIN CountyPopulation AS CP2 ON (CP1.county != CP2.county)
JOIN County AS C1 ON (C1.fips = CP1.county)
JOIN County AS C2 ON (C2.fips = CP2.county)
WHERE CP1.population >= 25000 AND CP2.population >= 25000 AND CP1.year = 2018 AND CP2.year = 2018
    AND C1.state = C2.state AND SIGN(CP1.population-CP2.population) = -1 
ORDER BY CP1.population/CP2.population DESC
LIMIT 1;
