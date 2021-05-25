Use pubs

--1. Numero de libros que tratan de cada tema

SELECT * FROM titles

SELECT type,COUNT(*) AS [Numero de libros] FROM titles GROUP BY type

--2. N�mero de autores diferentes en cada ciudad y estado

SELECT * FROM authors

SELECT au_id,city,state, COUNT(*) AS [Numero de autores] FROM authors GROUP BY au_id,city,state

--3. Nombre, apellidos, nivel y antig�edad en la empresa de los empleados con un nivel entre 100 y 150.

SELECT * FROM employee

SELECT fname,lname,job_lvl,hire_date, DATEDIFF(YEAR,hire_date,CURRENT_TIMESTAMP) AS [Antig�edad] FROM employee GROUP BY fname,lname,job_lvl,hire_date HAVING job_lvl BETWEEN 100 AND 150

--4. N�mero de editoriales en cada pa�s. Incluye el pa�s.

SELECT * FROM publishers

SELECT country, COUNT(pub_name) AS [Numero total de editoriales] FROM publishers GROUP BY country

--5. N�mero de unidades vendidas de cada libro en cada a�o (title_id, unidades y a�o).

SELECT * FROM sales

SELECT title_id,ord_date, COUNT(*) AS [Unidades vendidas] FROM sales GROUP BY title_id,ord_date

--6. N�mero de autores que han escrito cada libro (title_id y numero de autores).

SELECT * FROM titleauthor

SELECT title_id, COUNT(*) AS [Numero de autores] FROM titleauthor GROUP BY title_id

--7. ID, Titulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y t�tulo

SELECT * FROM titles

SELECT title_id,title,type,price, advance FROM titles WHERE 7000 < advance ORDER BY type,title
