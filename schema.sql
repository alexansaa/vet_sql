-- Create animals table
CREATE TABLE animals (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	date_of_birth DATE,
	escape_attempts INTEGER,
	neutered BOOLEAN,
	weight_kg DECIMAL(10,2)
);

-- Add the new "species" column
ALTER TABLE animals
ADD COLUMN species varchar(255);

-- Crate owners table
CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255) NOT NULL,
    age integer
);

-- Create species table
CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL
);

-- Drop the existing primary key constraint on "id" if it exists
ALTER TABLE animals DROP CONSTRAINT IF EXISTS animals_pkey;

-- Remove the existing "id" column
ALTER TABLE animals DROP COLUMN IF EXISTS id;

-- Add a new serial primary key constraint to the existing "id" column
ALTER TABLE animals
ADD COLUMN id serial PRIMARY KEY;

SELECT * FROM animals;

-- Remove the "species" column
ALTER TABLE animals DROP COLUMN IF EXISTS species;

SELECT * FROM animals;

-- Add a new "species_id" column as a foreign key referencing the "species" table
ALTER TABLE animals
ADD COLUMN species_id integer REFERENCES species(id);

SELECT * FROM animals;

-- Add a new "owner_id" column as a foreign key referencing the "owners" table
ALTER TABLE animals
ADD COLUMN owner_id integer REFERENCES owners(id);

SELECT * FROM animals;

