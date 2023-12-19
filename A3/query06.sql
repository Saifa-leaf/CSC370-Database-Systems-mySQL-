-- Retrieve by increasing snowfall the number of employees
-- in 'Mining, quarrying, and oil and gas extraction' for all
-- counties that have the words 'iron', 'coal', or 'mineral'
-- in their name.
-- 1.1 marks: <13 operators
-- 1.0 marks: <15 operators
-- 0.9 marks: <20 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT County.name, abbr, Table2.employees 
FROM State 
JOIN County ON (County.state = State.id) 
LEFT OUTER JOIN (
    SELECT county, employees 
    FROM CountyIndustries 
    JOIN Industry ON (CountyIndustries.industry = Industry.id) 
    WHERE Industry.name LIKE 'Mining, quarrying, and oil and gas extraction') 
AS Table2 ON (Table2.county = County.fips) 
WHERE County.name LIKE 'iron%' OR County.name LIKE 'coal%' OR County.name LIKE 'mineral%' 
ORDER BY snow;