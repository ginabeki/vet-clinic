/* Populate database with sample data. */

-- First entry
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '02-03-2020', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '11-15-2018', 2, TRUE, 8.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '01-07-2021', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '05-12-2017', 5, TRUE, 11.00);

-- Second entry
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '02-08-2020', 0, FALSE, -11.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '11-15-2021', 2, TRUE, -5.70);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '04-02-1993', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '06-12-2005', 1, TRUE, -45.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '06-07-2005', 7, TRUE, 20.40);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '10-13-1998', 3, TRUE, 17.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '05-14-2022', 4, TRUE, 22.00);

-- Owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Species table
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Update animals table
BEGIN;

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';


UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

COMMIT;


BEGIN;

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';

COMMIT;

-- Join visits

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (species_id, vet_id) 
VALUES (1, 1);
INSERT INTO specializations (species_id, vet_id) 
VALUES (1, 3);
INSERT INTO specializations (species_id, vet_id) 
VALUES (2, 3);
INSERT INTO specializations (species_id, vet_id) 
VALUES (2, 4);

INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (1, 3, '2020-06-22');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (5, 2, '2020-01-05');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (5, 2, '2020-03-08');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (5, 2, '2020-05-14');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (3, 3, '2021-05-04');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (9, 4, '2021-02-24');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (7, 2, '2019-12-21');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (7, 1, '2020-08-10');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (7, 2, '2021-04-07');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (10, 3, '2019-09-29');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (4, 2, '2019-01-24');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (4, 2, '2019-05-15');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (4, 2, '2020-02-27');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (4, 2, '2020-08-03');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (6, 3, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visits) 
VALUES (6, 1, '2021-01-11');