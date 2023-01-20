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