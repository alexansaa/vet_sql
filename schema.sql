-- Create animals table
CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	date_of_birth DATE,
	escape_attempts INTEGER,
	nautered BOOLEAN,
	weight_kg DECIMAL(10,2)
);

-- Add the new "species" column
ALTER TABLE animals
ADD COLUMN species varchar(255);