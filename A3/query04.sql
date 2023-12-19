-- Retrieve alphabetically all states in which
-- every county has a name not found anywhere else
-- in the US
-- 1.1 marks: <8 operators
-- 1.0 marks: <9 operators
-- 0.8 marks: correct answer


-- Replace this comment line with the actual query
SELECT abbr 
FROM State 
WHERE abbr NOT IN (
    SELECT abbr 
    FROM County AS C1 
    JOIN County AS C2 ON (C1.state != C2.state AND C1.name = C2.name) 
    JOIN State ON (C1.state = State.id)) 
ORDER BY abbr;