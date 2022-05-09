-- CHALLENGE 1
-- Paso 1
CREATE TEMPORARY TABLE paso1;
SELECT titles.title_id AS TITLE_ID, authors.au_id AS AUTHOR_ID, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS SALES_ROYALTY
FROM titleauthor
LEFT JOIN authors
USING (au_id)
LEFT JOIN titles
USING (title_id)
LEFT JOIN sales
USING (title_id);

-- Paso 2
CREATE TEMPORARY TABLE paso2;
SELECT TITLE_ID, AUTHOR_ID, SUM(SALES_ROYALTY) AS TOTAL_ROYALTY
FROM paso1
GROUP BY AUTHOR_ID, TITLE_ID;

-- Paso 3
SELECT AUTHOR_ID, SUM(TOTAL_ROYALTY) AS TOTAL_ROYALTY_AUTHOR
FROM paso2
GROUP BY AUTHOR_ID
ORDER BY TOTAL_ROYALTY_AUTHOR DESC
LIMIT 3;

-- CHALLENGE 2
-- Piso 1
SELECT titles.title_id AS TITLE_ID, authors.au_id AS AUTHOR_ID, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS SALES_ROYALTY
FROM titleauthor
LEFT JOIN authors
USING (au_id)
LEFT JOIN titles
USING (title_id)
LEFT JOIN sales
USING (title_id);

-- Paso 2
SELECT TITLE_ID, AUTHOR_ID, SUM(SALES_ROYALTY) AS TOTAL_ROYALTY
FROM 
(
SELECT titles.title_id as TITLE_ID, authors.au_id AS AUTHOR_ID, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS SALES_ROYALTY
FROM titleauthor 
LEFT JOIN authors 
USING (au_id) 
LEFT JOIN titles
USING (title_id)
LEFT JOIN sales
USING (title_id)
) AS tabla1
GROUP BY AUTHOR_ID, TITLE_ID;

-- Paso 3
SELECT AUTHOR_ID, SUM(TOTAL_ROYALTY) AS TOTAL_ROYALTY_AUTOR
FROM 
(
SELECT TITLE_ID, AUTHOR_ID, SUM(SALES_ROYALTY) AS TOTAL_ROYALTY
FROM 
(
SELECT titles.title_id AS TITLE_ID, authors.au_id AS AUTHOR_ID, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS SALES_ROYALTY
FROM titleauthor
LEFT JOIN authors
USING (au_id)
LEFT JOIN titles
USING (title_id)
LEFT JOIN sales
USING (title_id)
) AS tabla1
GROUP BY AUTHOR_ID, TITLE_ID
) AS tabla2
GROUP BY AUTHOR_ID
ORDER BY TOTAL_ROYALTY_AUTOR DESC
LIMIT 3;

-- Challenge 3

CREATE TABLE MOST_PROFITING_AUTHORS;
SELECT AUTHOR_ID, SUM(TOTAL_ROYALTY) AS PROFITS
FROM paso2
GROUP BY AUTHOR_ID
ORDER BY PROFITS DESC;