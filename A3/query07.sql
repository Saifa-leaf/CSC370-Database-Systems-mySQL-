-- Show which county has the largest relative population decrease
-- from 2010 to 2019.
-- 1.1 marks: <11 operators
-- 1.0 marks: <13 operators
-- 0.9 marks: <16 operators
-- 0.8 marks: correct answer


-- Replace this comment line with the actual query
SELECT County.name, CP1.population AS '2010', CP2.population AS '2019', abbr, (1-(CP2.population/CP1.population))*100 AS 'Loss (%)'
FROM CountyPopulation AS CP1
JOIN CountyPopulation AS CP2 ON (CP1.county = CP2.county)
JOIN County ON (County.fips = CP1.county)
JOIN State ON (State.id = County.state)
WHERE CP1.year LIKE 2010 AND CP2.year LIKE 2019
ORDER BY (CP2.population/CP1.population)
LIMIT 1;
