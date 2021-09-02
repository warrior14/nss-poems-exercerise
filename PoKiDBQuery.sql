-- What grades are stored in the database?
SELECT 
    Name [Grades]
FROM Grade;

-- What emotions may be associated with a poem?
SELECT 
    Name [Emotion Name]
FROM Emotion;

--How many poems are in the database?
SELECT
    COUNT(Id) [Total Poem Count]
FROM 
    Poem;