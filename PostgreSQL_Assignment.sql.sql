CREATE TABLE rangers(
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  region VARCHAR(100) NOT NULL
);
CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  common_name VARCHAR(100) NOT NULL,
  scientific_name VARCHAR(150) NOT NULL,
  discovery_date DATE,
  conservation_status VARCHAR(50)
);
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT REFERENCES rangers(ranger_id),
  species_id INT REFERENCES species(species_id),
  sighting_time TIMESTAMP,
  location VARCHAR(150),
  notes TEXT
);
INSERT INTO rangers (name, region)
VALUES 
  ('Alice Green', 'Northern Hills'),
  ('Bob White', 'River Delta'),
  ('Carol King', 'Mountain Range'),
  ('David Stone', 'Eastern Forest'),
  ('Evelyn Brooks', 'Savannah Plains'),
  ('Frank Moore', 'Wetland Reserve');
  INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES 
  ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
  ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
  ('Golden Eagle', 'Aquila chrysaetos', '1758-01-01', 'Least Concern'),
  ('Asian Black Bear', 'Ursus thibetanus', '1826-01-01', 'Vulnerable'),
  ('Indian Cobra', 'Naja naja', '1758-01-01', 'Least Concern'),
  ('Malayan Tapir', 'Tapirus indicus', '1811-01-01', 'Endangered');

  INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
  (1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
  (2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
  (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
  (1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL),
  (4, 1, 'River Bend',        '2024-05-20 14:00:00', 'Group of three seen'),
  (5, 3, 'Hilltop Ridge',     '2024-05-22 10:15:00', 'Soaring above the trees'),
  (6, 2, 'Forest Edge',       '2024-05-25 07:50:00', 'Tracks found nearby'),
  (7, 1, 'Marshland Area',    '2024-05-28 19:30:00', 'Spotted near water'),
  (8, 3, 'Mountain Pass',     '2024-06-01 08:20:00', 'Tracks and scat found'),
  (2, 1, 'Forest Pass',       '2024-06-03 17:45:00', 'Heard calls at dusk');

--1️⃣ Register a new ranger.
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

--2️⃣ Count unique species ever sighted.

SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

--3️⃣ Find all sightings where the location includes "Pass".

SELECT * FROM sightings WHERE location ILIKE '%pass%';
--4️⃣ List each ranger's name and their total number of sightings.
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name
ORDER BY total_sightings DESC;

--5️⃣ List species that have never been sighted.
SELECT sp.common_name
FROM species sp
LEFT JOIN sightings si ON sp.species_id = si.species_id
WHERE si.species_id IS NULL;


--6️⃣ Show the most recent 2 sightings.
SELECT *
FROM sightings
ORDER BY sighting_time DESC
LIMIT 2;
--7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


--8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.

SELECT 
  sighting_id,
  CASE 
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

--9️⃣ Delete rangers who have never sighted any speciesDELETE FROM rangers
DELETE FROM rangers
WHERE NOT EXISTS (
  SELECT 1
  FROM sightings
  WHERE sightings.ranger_id = rangers.ranger_id
);









SELECT * from species;
SELECT * from sightings;



