-- Retrieve alphabetically the states that had
-- over 100 counties with unemployment rates above 6.0%
-- in 2008.
-- Hint: Unemployment rate = unemployed / labour force
-- 1.1 marks: <8 operators
-- 1.0 marks: <9 operators
-- 0.9 marks: <11 operators
-- 0.8 marks: correct answer


-- Replace this comment line with the actual query
SELECT abbr
FROM State
JOIN County ON (County.state = State.id)
JOIN CountyLabourStats ON (CountyLabourStats.county = County.fips)
WHERE CountyLabourStats.year = 2008 and (unemployed / labour_force)*100 > 6
GROUP BY state
HAVING count(state) > 100
ORDER BY abbr;