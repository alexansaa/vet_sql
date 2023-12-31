-- Find all animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are nauteres and have less than 3 escape attempts
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu":
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


--Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
-- Start a transaction
BEGIN;

-- Update the "species" column for all animals to "unspecified"
UPDATE animals
SET species = 'unspecified';

-- Verify the change by selecting the updated data
SELECT * FROM animals;

-- Roll back the transaction to revert the update
ROLLBACK;


--Inside a transaction:
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
--Verify that changes were made.
--Commit the transaction.
--Verify that changes persist after commit.
-- Start a transaction
BEGIN;

-- Update the "species" column to "digimon" for animals with names ending in "mon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the "species" column to "pokemon" for animals without a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';

-- Verify the changes within the transaction
SELECT * FROM animals;

-- Commit the transaction
COMMIT;


--Inside a transaction delete all records in the animals table, then roll back the transaction.
--After the rollback verify if all records in the animals table still exists.
-- Start a transaction
BEGIN;

-- Delete all records from the "animals" table
DELETE FROM animals;

-- Verify the change by selecting the updated data
SELECT * FROM animals;

-- Roll back the transaction to undo the deletion
ROLLBACK;

--Verify all records in the animals table still exists
SELECT * FROM animals;

--Inside a transaction:
--Delete all animals born after Jan 1st, 2022.
--Create a savepoint for the transaction.
--Update all animals' weight to be their weight multiplied by -1.
--Rollback to the savepoint
--Update all animals' weights that are negative to be their weight multiplied by -1.
--Commit transaction
-- Start a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT weight_update_savepoint;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO weight_update_savepoint;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Verify the change by selecting the updated data
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

--Write queries to answer the following questions:
--How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;
--How many animals have never tried to escape?
SELECT COUNT(*) AS no_escape_animals FROM animals WHERE escape_attempts = 0;
--What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;
--Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;
--What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Update animals with names ending in "mon" to have species_id of Digimon
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

-- Update all other animals to have species_id of Pokemon
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

SELECT * FROM animals;

-- Write queries (using join) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT o.full_name, COALESCE(array_agg(a.name), '{}'::text[]) AS animals_owned
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name;

-- How many animals are there per species?
SELECT s.name AS species_name, COUNT(*) AS animal_count
FROM animals AS a
LEFT JOIN species AS s ON a.species_id = s.id
GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
JOIN species AS s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals AS a
JOIN owners AS o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(a.name) AS animal_count
FROM owners AS o
LEFT JOIN animals AS a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT a.name AS last_animal_seen_by_William_Tatcher
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 1
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS number_of_animals_seen_by_Stephanie_Mendez
FROM visits v
WHERE v.vet_id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 3
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*)
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name AS first_visit_animal_by_Maisy_Smith
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 2
ORDER BY v.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.id AS animal_id, a.name AS animal_name, v.vet_id AS vet_id, vs.name AS vet_name, v.visit_date AS most_recent_visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vs ON v.vet_id = vs.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS visits_with_non_specialized_vet
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id
LEFT JOIN specializations s ON vet.id = s.vet_id AND a.species_id = s.species_id
WHERE s.specialization_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS potential_specialty
FROM (
    SELECT a.species_id, COUNT(*) AS visit_count
    FROM visits v
    JOIN animals a ON v.animal_id = a.id
    WHERE v.vet_id = 2
    GROUP BY a.species_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited_species
JOIN species s ON most_visited_species.species_id = s.id;
