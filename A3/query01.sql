-- Retrieve the state with the median number of
-- employees in 'Education Services'
-- 1.1 marks: < 10 operators
-- 1.0 marks: < 11 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT abbr, SUM(employees) AS TotalEmployees 
FROM CountyIndustries 
    JOIN Industry ON (CountyIndustries.industry = Industry.id) 
    JOIN County ON (CountyIndustries.county = County.fips)  
    JOIN State ON (State.id = County.state) 
WHERE Industry.name = 'Educational services' 
GROUP BY abbr 
ORDER BY TotalEmployees 
LIMIT 25 , 1;