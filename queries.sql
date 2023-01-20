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

-- join table for visits queries

SELECT A.name as animals_name, V.date_of_visits, VE.name as vet_name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id 
WHERE VE.name = 'William Tatcher'
ORDER BY date_of_birth ASC
LIMIT 1;

SELECT COUNT(A.name) as animals, VE.name as vet_name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id
WHERE VE.name = 'Stephanie Mendez'
GROUP BY VE.name;

SELECT VE.name as vet_name, S.name as speciality
FROM vets VE
FULL OUTER JOIN specializations SP ON SP.vet_id = VE.id
FULL OUTER JOIN species S ON S.id = SP.species_id;

SELECT A.name as animals_name, V.date_of_visits, VE.name as vet_name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id 
WHERE VE.name = 'Stephanie Mendez'
AND V.date_of_visits 
BETWEEN '2020-04-01' AND '2020-08-30';

SELECT A.name as animals_name, COUNT(V.date_of_visits) as number_of_visits
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id
GROUP BY A.name
ORDER BY COUNT(V.date_of_visits) DESC
LIMIT 1;

SELECT A.name as animals_name, V.date_of_visits as last_visit_date, VE.name as vet_name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id 
WHERE VE.name = 'Maisy Smith'
ORDER BY V.date_of_visits ASC
LIMIT 1;

SELECT A.name as animals_info, VE.name as vet_info, V.date_of_visits
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id
WHERE a.name = (
SELECT A.name FROM animals A JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON VE.id = V.vet_id GROUP BY A.name
ORDER BY COUNT(V.date_of_visits) DESC LIMIT 1
);

-- create a Common Table Expression (CTE)
WITH visits_not_specialized AS (
    SELECT V.*, A.*, SP.*
    FROM visits V
    JOIN animals A ON V.animal_id = A.id
    LEFT JOIN specializations SP ON A.species_id = SP.species_id AND V.vet_id = SP.vet_id
    WHERE SP.species_id IS NULL
)
SELECT COUNT(*) as visits_not_specialized
FROM visits_not_specialized;

WITH animals_by_species_count AS (
    SELECT S.name, A.species_id, COUNT(*) as number_of_animals
    FROM visits V
    JOIN animals A ON V.animal_id = A.id
    JOIN vets VE ON V.vet_id = VE.id
    JOIN species S ON S.id = A.species_id
    WHERE VE.name = 'Maisy Smith'
    GROUP BY A.species_id, S.name
    ORDER BY number_of_animals DESC
)  
SELECT *
FROM animals_by_species_count
LIMIT 1;