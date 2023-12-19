-- Retrieve alphabetically all states
-- with at least one hundred counties.
-- 1.1 marks: <6 operators
-- 1.0 marks: <8 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT abbr
FROM State
JOIN County ON (County.state = State.id)
GROUP BY state
HAVING count(state) >= 100
ORDER BY abbr;
