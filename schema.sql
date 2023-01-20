/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(100),
    date_of_birth       DATE,
    escape_attempts     INT,
    neutered            BOOLEAN,
    weight_kg           FLOAT,
    PRIMARY KEY(id)
);

-- Add column
ALTER TABLE animals
ADD species VARCHAR(100);

-- Query multiple table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


BEGIN;

ALTER TABLE animals 
  DROP COLUMN species;

ALTER TABLE animals
  ADD COLUMN species_id INT REFERENCES species(id),
  ADD COLUMN owner_id INT REFERENCES owners(id);

COMMIT;

-- Join visits
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
);

-- many-to-many join-table
CREATE TABLE specializations (
   species_id INTEGER REFERENCES species(id),
   vet_id INTEGER REFERENCES vets(id),
   UNIQUE (species_id, vet_id)
);

-- many-to-many join-table
CREATE TABLE visits (
   animal_id INTEGER REFERENCES animals(id),
   vet_id INTEGER REFERENCES vets(id),
   date_of_visits DATE NOT NULL,
   UNIQUE (animal_id, vet_id, date_of_visits)
);