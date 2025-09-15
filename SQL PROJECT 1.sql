create database Music;
use Music;
select *from album;

-- Q1 : Who is the senior most employee based on job title?

select *from employee
ORDER BY levels desc
limit 1;

-- Q2: List all album names with artist IDs
SELECT album_id, title, artist_id FROM album;

-- Q3. Which countries have the most Invoices?

select count(*) as c, billing_country
from invoice
group by billing_country
order by c desc;

-- Q4. What are top 3 values of total invoice?

select total from invoice
order by total desc
limit 3;

-- Q5. Which city has the best customers? We would like to throw a promotional Music
-- Festival in the city we made the most money. Write a query that returns one city that
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice
-- totals?

select sum(total) as invoice_total, billing_city
from invoice group by billing_city
order by invoice_total desc;

-- Q:6  Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with A

Select distinct email,first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in 
(Select track_id from track
      Join genre on track.genre_id = genre.genre_id 
      where genre.name = 'Rock')
      Order By email;

-- Q:7. Let's invite the artists who have written the most rock music in our dataset. Write a
-- query that returns the Artist name and total track count of the top 10 rock bands

Select artist.name,count(track.track_id) as number_of_songs
from track
join album on track.album_id = album.album_id  
join artist on  album.album_id = artist.artist_id 
join genre on  track.genre_id = genre.genre_id
where genre.name = 'Rock'
Group by artist.artist_id , artist.name
order by number_of_songs Desc
Limit 10;

-- Q:8 Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the
-- longest songs listed first

Select name, milliseconds from track
where milliseconds >( select avg (milliseconds) as avg_track_length from track)
order by milliseconds desc;

-- Q9: List the top 5 longest tracks (by milliseconds)
SELECT name, milliseconds
FROM track
ORDER BY milliseconds DESC
LIMIT 5;

-- Q10: Show employees and the customers they support
SELECT e.first_name AS employee_name, c.first_name AS customer_name
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id;

-- Q:11  Total Sales Per Customer
SELECT c.first_name, c.last_name, SUM(i.total) AS total_spent FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name;

-- Q:12 Top 5 Genres by Number of Tracks
SELECT g.name AS genre, COUNT(t.track_id) AS track_count FROM genre g
JOIN track t ON g.genre_id = t.genre_id
GROUP BY g.genre_id,g.name
ORDER BY track_count DESC
LIMIT 5;