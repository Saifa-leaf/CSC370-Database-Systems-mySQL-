-- Show which industries in which states (except DC)
-- employed at least 7.5% of the state's 2019 population,
-- ordered by the total payroll for that industry
-- in that state.
-- 1.1 marks: <26 operators
-- 1.0 marks: <30 operators
-- 0.9 marks: <35 operators
-- 0.8 marks: correct answer


-- Replace this comment line with the actual query
SELECT EachStatePop.abbr, Industry.name, PopEmployeesState.Payrolls AS 'Total Payrolls', (EachStateEmployee/TotalPopOfState)*100 AS '% of Population'
FROM (
    SELECT S2.abbr, SUM(population) AS TotalPopOfState
    FROM CountyPopulation
    JOIN County AS C2 ON (C2.fips = CountyPopulation.county)
    JOIN State AS S2 ON (S2.id = C2.state)
    WHERE CountyPopulation.year LIKE 2019
    GROUP BY S2.abbr
) AS EachStatePop
JOIN (
    SELECT S3.abbr, CI3.industry, SUM(employees) AS EachStateEmployee, SUM(CI3.payroll) AS Payrolls
    FROM CountyIndustries AS CI3
    JOIN County AS C3 ON (C3.fips = CI3.county)
    JOIN State AS S3 ON (S3.id = C3.state)
    GROUP BY S3.abbr, CI3.industry
) AS PopEmployeesState ON (PopEmployeesState.abbr = EachStatePop.abbr)
JOIN Industry ON (PopEmployeesState.industry = Industry.id)
WHERE (EachStateEmployee/TotalPopOfState)*100 >= 7.5 AND EachStatePop.abbr NOT LIKE 'DC'
ORDER BY PopEmployeesState.Payrolls DESC;