# 🎬 BookMyShow Database Design & Normalization
## Problem Statement :
Bookmyshow is a ticketing platform where you can book tickets for a movie show. The image attached represents that for a given theatre we can see the next 7 dates. As one chooses the date, we get list of all shows running in that theatre along with the show timings.

P1 - As part of this assignment, we need to list down all the entities, their attributes and the table structures for the scenario mentioned in the previous slide. You also need to write the SQL queries required to create these tables along with few sample entries. Ensure the tables follow 1NF, 2NF, 3NF and BCNF rules.

P2 - Write a query to list down all the shows on a given date at a given theatre along with their respective show timings.
## 📌 Objective

This project focuses on database design decisions rather than just writing SQL queries.
The goal was to design a clean and scalable schema for a simplified movie booking system by applying proper normalization principles: 1NF → 2NF → 3NF → BCNF.

---

## 🧩 Step 0: Unnormalized Form (UNF)

Initially, everything could be stored in a single table:

Movie_System(
theatre_id,
theatre_name,
theatre_image,
cinema_id,
cinema_name,
show_id,
show_date,
show_time
)

### Problems Identified

* Theatre details repeated for every show
* Cinema details repeated for every show
* High redundancy
* Update anomalies
* Delete anomalies
* Insert anomalies

This structure is not scalable.

---

## ✅ Step 1: First Normal Form (1NF)

### Rule:

* All attributes must be atomic
* No repeating groups

All attributes are atomic:

* theatre_name → single value
* cinema_name → single value
* show_date → single value
* show_time → single value

The table satisfies 1NF structurally, but redundancy still exists.

No decomposition yet — only structural validation.

---

## ✅ Step 2: Second Normal Form (2NF)

### Rule:

* Must be in 1NF
* No partial dependency
* Every non-key attribute must fully depend on the primary key

Assume a composite key:

(theatre_id, cinema_id, show_date, show_time)

Functional dependencies observed:

theatre_id → theatre_name, theatre_image ❌
cinema_id → cinema_name ❌

These are partial dependencies because they depend only on part of the composite key.

This violates 2NF.

---

## 🔥 Decomposition for 2NF

We separate attributes based on their determinants.

### 🎭 Theatre Table

```sql
CREATE TABLE Theatre(
    theatre_id SERIAL PRIMARY KEY,
    theatre_name VARCHAR(100),
    theatre_image BYTEA
);
```

Functional Dependency:
theatre_id → theatre_name, theatre_image

---

### 🎥 Cinema Table

```sql
CREATE TABLE Cinema(
    cinema_id SERIAL PRIMARY KEY,
    cinema_name VARCHAR(255)
);
```

Functional Dependency:
cinema_id → cinema_name

---

### 🕒 Running_Show Table

```sql
CREATE TABLE Running_Show(
    show_id SERIAL PRIMARY KEY,
    theatre_id INT,
    cinema_id INT,
    show_date DATE,
    show_time TIME,
    CONSTRAINT fk_show_theatre
        FOREIGN KEY (theatre_id)
        REFERENCES Theatre(theatre_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_show_cinema
        FOREIGN KEY (cinema_id)
        REFERENCES Cinema(cinema_id)
        ON DELETE CASCADE
);
```

Functional Dependency:
show_id → theatre_id, cinema_id, show_date, show_time

Now:

* No partial dependency
* 2NF satisfied

---

## ✅ Step 3: Third Normal Form (3NF)

### Rule:

* Must be in 2NF
* No transitive dependency

Example of transitive dependency:

show_id → theatre_id
theatre_id → theatre_name

If theatre_name were stored inside Running_Show:

show_id → theatre_id → theatre_name ❌

That would violate 3NF.

Since theatre_name and cinema_name are stored in separate tables:

* No transitive dependency
* 3NF satisfied

---

## ✅ Step 4: Boyce-Codd Normal Form (BCNF)

### Rule:

For every functional dependency X → Y,
X must be a super key.

Check each table:

Theatre
theatre_id → theatre_name, theatre_image ✔ (Primary Key)

Cinema
cinema_id → cinema_name ✔ (Primary Key)

Running_Show
show_id → theatre_id, cinema_id, show_date, show_time ✔ (Primary Key)

All determinants are candidate keys.

BCNF satisfied.

---

## 🎯 Final Schema

### Theatre

* theatre_id (PK)
* theatre_name
* theatre_image

### Cinema

* cinema_id (PK)
* cinema_name

### Running_Show

* show_id (PK)
* theatre_id (FK)
* cinema_id (FK)
* show_date
* show_time

---

