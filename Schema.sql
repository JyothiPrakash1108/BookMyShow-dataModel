CREATE TABLE Theatre(
	 	theatre_id SERIAL PRIMARY KEY,
		theatre_name VARCHAR(100) ,
	 	theatre_image BYTEA
);

CREATE TABLE Cinema(
	cinema_id SERIAL PRIMARY KEY,
	cinema_name VARCHAR(255) 
);

CREATE TABLE Running_Show(
	show_id SERIAL PRIMARY KEY,
	theatre_id INT ,
	cinema_id INT ,
	show_date DATE,
	show_time TIME,
	 CONSTRAINT
	 fk_show_theatre 
	 FOREIGN KEY (theatre_id) 
	 REFERENCES Theatre(theatre_id)
	 ON DELETE CASCADE,
	 CONSTRAINT
	 fk_show_cinema 
	 FOREIGN KEY (cinema_id) 
	 REFERENCES Cinema(cinema_id)
	 ON DELETE CASCADE
);

