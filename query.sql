-- Theatres
SELECT * FROM theatre;

-- Cinema
SELECT * FROM cinema;

-- Running shows
SELECT * FROM running_show;

-- shows running on the date 
SELECT FROM c.cinema_name , t.theatre_name , s.show_date running_show s
JOIN cinema c
ON s.cinema_id = c.cinema_id
JOIN theatre t 
ON s.theatre_id = t.theatre_id
WHERE s.show_date = '2024-12-20';

