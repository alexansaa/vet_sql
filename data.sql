-- Insert data for Agumon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

-- Insert data for Gabumon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, true, 8);

-- Insert data for Pikachu
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

-- Insert data for Devimon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, true, 11);

-- Insert data for Charmander
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11.0);

-- Insert data for Plantmon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

-- Insert data for Squirtle
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

-- Insert data for Angemon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', '2005-06-12', 1, true, -45.0);

-- Insert data for Boarmon
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

-- Insert data for Blossom
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', '1998-10-13', 3, true, 17.0);

-- Insert data for Ditto
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Ditto', '2022-05-14', 4, true, 22.0);

-- Inserting data into owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);

SELECT * FROM owners;

-- Insert data into species table
INSERT INTO species (name)
VALUES ('Pokemon');

INSERT INTO species (name)
VALUES ('Digimon');

-- Modify inserted animals to include owner information (owner_id):
-- Update animals owned by Sam Smith
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

-- Update animals owned by Jennifer Orwell
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

-- Update animals owned by Bob
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

-- Update animals owned by Melody Pond
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update animals owned by Dean Winchester
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

-- Insert data into vets table
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', 45, '2000-04-23'),
    ('Vet Maisy Smith', 26, '2019-01-17'),
    ('Vet Stephanie Mendez', 64, '1981-05-04'),
    ('Vet Jack Harkness', 38, '2008-06-08');

-- Inserted data into specializations table
INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1), -- Vet William Tatcher specialized in Pokemon
    (3, 2), -- Vet Stephanie Mendez specialized in Digimon
    (3, 1), -- Vet Stephanie Mendez specialized in Pokemon
    (4, 2); -- Vet Jack Harkness specialized in Digimon

-- Insert data into visits table
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    (1, 1, '2020-05-24'),     -- Agumon visited William Tatcher on May 24th, 2020
    (1, 3, '2020-07-22'),     -- Agumon visited Stephanie Mendez on Jul 22nd, 2020
    (2, 4, '2021-02-02'),     -- Gabumon visited Jack Harkness on Feb 2nd, 2021
    (3, 2, '2020-01-05'),     -- Pikachu visited Maisy Smith on Jan 5th, 2020
    (3, 2, '2020-03-08'),     -- Pikachu visited Maisy Smith on Mar 8th, 2020
    (3, 2, '2020-05-14'),     -- Pikachu visited Maisy Smith on May 14th, 2020
    (4, 3, '2021-05-04'),     -- Devimon visited Stephanie Mendez on May 4th, 2021
    (5, 4, '2021-02-24'),     -- Charmander visited Jack Harkness on Feb 24th, 2021
    (6, 2, '2019-12-21'),     -- Plantmon visited Maisy Smith on Dec 21st, 2019
    (6, 1, '2020-08-10'),     -- Plantmon visited William Tatcher on Aug 10th, 2020
    (6, 2, '2021-04-07'),     -- Plantmon visited Maisy Smith on Apr 7th, 2021
    (7, 3, '2019-09-29'),     -- Squirtle visited Stephanie Mendez on Sep 29th, 2019
    (8, 4, '2020-10-03'),     -- Angemon visited Jack Harkness on Oct 3rd, 2020
    (8, 4, '2020-11-04'),     -- Angemon visited Jack Harkness on Nov 4th, 2020
    (9, 2, '2019-01-24'),     -- Boarmon visited Maisy Smith on Jan 24th, 2019
    (9, 2, '2019-05-15'),     -- Boarmon visited Maisy Smith on May 15th, 2019
    (9, 2, '2020-02-27'),     -- Boarmon visited Maisy Smith on Feb 27th, 2020
    (9, 2, '2020-08-03'),     -- Boarmon visited Maisy Smith on Aug 3rd, 2020
    (10, 1, '2020-05-24'),    -- Blossom visited William Tatcher on May 24th, 2020
    (10, 3, '2021-01-11');    -- Blossom visited Stephanie Mendez on Jan 11th, 2021
