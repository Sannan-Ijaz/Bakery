CREATE DATABASE bakersInc;

CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    quantity REAL,
    destination TEXT,
    image_url TEXT
);

INSERT INTO inventory (
    name,quantity, destination, image_url
) VALUES ('Black-Forrest', 5, 'Tutts Bakers', 'None' );