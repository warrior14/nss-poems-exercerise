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

--Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT DISTINCT
    TOP 76 Name [Author Name]
FROM Author
ORDER BY
 Name;

 -- Starting with the above query, add the grade of each of the authors
 SELECT DISTINCT TOP 76
    a.Name [Author Name],
    g.Name [Grade]
FROM Author a
INNER JOIN Grade g
ON a.GradeId = g.Id
ORDER BY a.Name;

--Starting with the above query, add the recorded gender of each of the authors.
SELECT DISTINCT TOP 76
    a.Name [Author Name],
    g.Name [Grade],
    gen.Name [Gender]
FROM Author a
INNER JOIN Grade g
ON a.GradeId = g.Id
INNER JOIN Gender gen
ON a.GenderId = gen.Id
ORDER BY a.Name;


----What is the total number of words in all poems in the database?
SELECT 
    SUM(WordCount) [Total Word Count in ALL Poems]
FROM Poem;

--Which poem has the fewest characters?
SELECT 
    POEM.Title [Poem Title],
    MIN(CharCount) [Fewest Character Count]
FROM Poem
GROUP BY Poem.Title
HAVING MIN(POEM.CharCount) = 6;