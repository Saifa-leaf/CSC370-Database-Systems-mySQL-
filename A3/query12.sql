-- Retrieve alphabetically the names of industries that
-- employ at least five million workers across
-- the US, excluding California.
-- 1.1 marks: <9 operators
-- 1.0 marks: <11 operators
-- 0.9 marks: <14 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT Industry.name
FROM CountyIndustries
JOIN Industry ON (Industry.id = CountyIndustries.industry)
JOIN County ON (County.fips = CountyIndustries.county)
JOIN State ON (State.id = County.state)
WHERE abbr NOT LIKE 'CA'
GROUP BY industry
HAVING SUM(employees) >= 5000000
ORDER BY Industry.name;
