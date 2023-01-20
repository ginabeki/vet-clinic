/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Second entry*/

-- Transaction 1
BEGIN;
UPDATE animals
SET species = 'unspecified';

TABLE animals;

ROLLBACK;

TABLE animals;

-- Transaction 2
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

SELECT * FROM animals;

-- Transaction 3
BEGIN;

DELETE FROM animals;
TABLE animals;

ROLLBACK;

TABLE animals;

-- Transaction 4
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Queries to answer provided questions
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals 
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Queries using JOIN
SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Melody Pond';

SELECT animals.name, species.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name, name
FROM owners
FULL JOIN animals ON owners.id = animals.owner_id;


SELECT species.name, COUNT(animals.name)
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Jennifer Orwell' AND animals.species_id = 2;

SELECT full_name, name
FROM owners
JOIN animals ON owners.id = animals.owner_id
WHERE full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT full_name, COUNT(name)
FROM owners
FULL JOIN animals ON owners.id = animals.owner_id
GROUP BY full_name;