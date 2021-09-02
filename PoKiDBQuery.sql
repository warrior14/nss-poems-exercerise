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

--How many authors are in the third grade?
SELECT
	COUNT(a.GradeId) [Number of Authors in 3rd Grade]
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name = '3rd Grade';
--WHERE g.Id = 3;

--How many total authors are in the first through third grades?
SELECT
	COUNT(a.GradeId) [Total Number of Authors From 1st-3rd Grades]
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name BETWEEN '1st Grade' AND '3rd Grade';
--WHERE g.Name NOT LIKE '4%' OR '5%';
--WHERE g.Name IN (LIKE '%1st%' OR '%2nd%' OR '%3rd%');
--OR CAN QUERY THIS WAY:
SELECT
	COUNT(DISTINCT a.Id) [Total Number of Authors From 1st-3rd Grades]
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE
	g.Id = 1
OR
	g.Id = 2
OR
	g.Id = 3;
--THIS QUERY GIVES TOTAL SUM OF AUTHORS in 1st - 3rd Grades:
SELECT
	SUM(a.GradeId) [Total Number of Authors From 1st-3rd Grades]
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name BETWEEN '1st Grade' AND '3rd Grade';

--What is the total number of poems written by fourth graders?
SELECT
	COUNT(p.Id) [Total Number of Poems By 4th Graders]
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
WHERE g.Name = '4th Grade';

--How many poems are there per grade?
SELECT
	g.Name [Grade],
	COUNT(p.Id) [Number of Poems Per Grade]
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name; 

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT
	g.Name [Grade],
	COUNT(a.Id) [Number of Authors Per Grade]
FROM Author a
LEFT JOIN Grade g
ON a.GradeId = g.Id
GROUP BY g.Name
ORDER BY g.Name;

--What is the title of the poem that has the most words?
SELECT MAX(p.WordCount) [Most Word Count in a Poem]
FROM Poem p

SELECT
	p.Title [Poem Title With Most Words],
	MAX(p.WordCount) [Most Word Count]
FROM Poem p
GROUP BY p.Title
HAVING MAX(p.WordCount) = 263;
--OR CAN QUERY THIS WAY:
SELECT 
	TOP(1) Title [Poem Title With Most Words],
	WordCount [Most Word Count]
FROM Poem 
ORDER BY WordCount DESC;

--Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT 
	a.Name [Author Name], 
	COUNT(p.AuthorId) [Most Number of Poems Count]
FROM Poem p
LEFT JOIN Author a
ON p.AuthorId = a.Id
GROUP BY a.Name
HAVING COUNT(p.AuthorId)> 300
ORDER BY a.Name;
--SELECT 
--	DISTINCT a.Name [Author Name],
--	COUNT(p.AuthorId) [Most Number of Poems]
--FROM Poem p
--LEFT JOIN Author a
--ON p.AuthorId = a.Id
--WHERE p.AuthorId = 8725
--GROUP BY a.Name
--ORDER BY a.Name;

--OR CAN QUERY THIS WAY:
SELECT TOP(1) 
	a.Name [Author Name], 
	COUNT(p.Id) [Most Number of Poems Count]
FROM Author a
INNER JOIN Poem p
	ON a.Id = p.AuthorId
GROUP BY a.Name
ORDER BY COUNT(p.Id) DESC;

--How many poems have an emotion of sadness?
SELECT
	e.Name [Emotion Name],
	COUNT(pe.PoemId) [Poem Count]
FROM PoemEmotion pe
INNER JOIN Emotion e
ON pe.EmotionId = e.Id
WHERE e.Id = 3
--WHERE e.Name = 'Sadness';
GROUP BY e.Name;

--OR CAN QUERY THIS WAY:
SELECT 
	e.Name [Emotion Name],
	COUNT(p.Id) [Poem Count]
FROM PoemEmotion pe
INNER JOIN Poem p
ON pe.PoemId = p.Id
INNER JOIN Emotion e
ON pe.EmotionId = e.Id
WHERE e.Name = 'Sadness'
GROUP BY e.Name;


--How many poems are not associated with any emotion?
SELECT 
	COUNT(p.Id) [Poem Count]
FROM Poem p
LEFT JOIN PoemEmotion pe
ON p.Id = pe.PoemId 
WHERE pe.EmotionId IS NULL;

--OR CAN QUERY THIS WAY WITH RIGHT JOIN DEPENDING OF ORDER OF TABLES:
SELECT 
	COUNT(p.Id) [Poem Count]
FROM PoemEmotion pe
RIGHT JOIN Poem p
ON pe.PoemId = p.Id
WHERE pe.EmotionId IS NULL;

--Which emotion is associated with the least number of poems?
SELECT 
	TOP(1) e.Name [Emotion Name], 
	COUNT(p.Id) [Poem Count]
FROM PoemEmotion pe
INNER JOIN Poem p
ON pe.PoemId = p.Id
INNER JOIN Emotion e
ON pe.EmotionId = e.Id
GROUP BY e.Name
ORDER BY COUNT(p.Id) DESC;
--CAN ALSO USE MIN() IN QUERY TO ACHIEVE SAME RESULT

--Which grade has the largest number of poems with an emotion of joy?

SELECT
	TOP(1) g.Name [Grade], 
	e.Name [Emotion Name], 
	COUNT(p.Id) [Poem Count]
FROM Poem p
INNER JOIN PoemEmotion pe
ON p.Id = pe.PoemId
INNER JOIN Emotion e
ON pe.EmotionId = e.Id
INNER JOIN Author a
ON p.AuthorId = a.Id
INNER JOIN Grade g 
ON a.GradeId = g.Id
WHERE e.Name = 'Joy'
GROUP BY 
	g.Name, 
	e.Name
ORDER BY COUNT(p.Id) DESC;

--Which gender has the least number of poems with an emotion of fear?

SELECT 
	TOP(1) ge.Name [Gender], 
	e.Name [Emotion Name], 
	COUNT(p.Id) [Poem Count]
FROM Poem p
INNER JOIN PoemEmotion pe
ON p.Id = pe.PoemId
INNER JOIN Emotion e
ON pe.EmotionId = e.Id
INNER JOIN Author a
ON p.AuthorId = a.Id
INNER JOIN Gender ge 
ON a.GenderId = ge.Id
WHERE e.Name = 'Fear'
GROUP BY 
	ge.Name, 
	e.Name
ORDER BY COUNT(p.Id) ASC;