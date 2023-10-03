-- Create animals table
CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	date_of_birth DATE,
	escape_attempts INTEGER,
	nautered BOOLEAN,
	weight_kg DECIMAL(10,2)
);
