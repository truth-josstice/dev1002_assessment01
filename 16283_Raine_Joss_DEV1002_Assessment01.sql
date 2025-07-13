DROP TABLE IF EXISTS equipped_weapons;
DROP TABLE IF EXISTS characters;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS spells;
DROP TABLE IF EXISTS base_stats;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS weapons;

CREATE TABLE weapons(
    weapon_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    type VARCHAR(16) NOT NULL,
    power INT NOT NULL,
    range INT NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE skills(
    skill_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    description VARCHAR(255) NOT NULL,
    max_uses VARCHAR(16)
);

CREATE TABLE base_stats(
    stats_id SERIAL PRIMARY KEY,
    hp INT NOT NULL,
    mp INT NOT NULL,
    atk INT NOT NULL,
    mag INT NOT NULL,
    def INT NOT NULL,
    mov INT CHECK (mov <= 10) NOT NULL
);

CREATE TABLE spells(
    spell_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    element VARCHAR(16) NOT NULL,
    effect VARCHAR(255) NOT NULL,
    mp_cost INT NOT NULL,
    range INT NOT NULL,
    area_of_effect INT NOT NULL,
    damage_factor FLOAT,
    healing_factor FLOAT
);

CREATE TABLE classes(
    class_id SERIAL PRIMARY KEY,
    stats_id INT NOT NULL REFERENCES base_stats(stats_id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(skill_id) ON DELETE CASCADE,
    spell_id INT NOT NULL REFERENCES spells(spell_id) ON DELETE SET NULL,
    sub_weapon_id INT REFERENCES weapons(weapon_id) ON DELETE SET NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE characters(
    character_id SERIAL PRIMARY KEY,
    class_id INT NOT NULL REFERENCES classes(class_id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    age INT,
    race VARCHAR(32) NOT NULL,
    level INT CHECK (level <= 20) NOT NULL
);

CREATE TABLE equipped_weapons(
    equipped_id SERIAL PRIMARY KEY,
    weapon_id INT NOT NULL REFERENCES weapons(weapon_id) ON DELETE CASCADE,
    character_id INT NOT NULL REFERENCES characters(character_id) ON DELETE CASCADE
);

INSERT INTO weapons (name, type, power, range, description) VALUES
('Shortsword', 'Melee', 8, 5, 'A sturdy but blunt beginner shortsword'),
('Spear', 'Melee', 7, 10, 'A wooden rod with a sharp metal point, can reach further than a lance'),
('Bow', 'Ranged', 5, 40, 'A shortbow with a loose string, weak but beginner friendly'),
('Axe', 'Melee', 8, 5, 'A heavy blunt axe, more likely to crush than cut'),
('Dagger', 'Thrown', 3, 20, 'A thrown dagger, very weak but maybe you could hit a vital point'),
('Staff', 'Melee', 1, 5, 'Incredibly weak, wizards use bonk attack...it is not very effective'),
('Hunting Knife', 'Melee', 4, 5, 'A secondary weapon common with rangers, used to skin hunted animals');

INSERT INTO skills (name, description, max_uses) VALUES
('Oomph', 'Brute strength, boosts your defence for three rounds at the start of battle', 'N/A'),
('Lay of the Land', 'Before heading into a dungeon, scout to ascertain the difficulty of enemies', 'Once per rest'),
('Sneak', 'Sneak past an enemy during battle, allowing the party to escape', 'Five'),
('Undermine', 'Uses wizards intellect to confuse a guardian', 'Three'),
('Blitz', 'Attacks twice with a melee weapon', 'Once per battle'),
('Pray', 'Instantly destroys one undead enemy', 'Once per battle');

INSERT INTO base_stats (hp, mp, atk, mag, def, mov) VALUES
(20, 10, 10, 0, 10, 4),
(30, 3, 12, 0, 12, 3),
(10, 36, 1, 10, 7, 3),
(15, 20, 5, 5, 8, 6),
(12, 12, 7, 3, 6, 5);

INSERT INTO spells (name, element, effect, mp_cost, range, area_of_effect, damage_factor, healing_factor) VALUES
('Sharpen', 'Buff', 'Magically sharpens sword, damage plus 2', 3, 0, 0, NULL, NULL),
('Roar', 'Debuff', 'May scare opponent, 5% chance to lower defence', 1, 10, 10, NULL, NULL),
('Blaze', 'Fire', 'Sets fire to your opponent', 6, 20, 5, 1.20, NULL),
('Darkness', 'Dark', 'Blinds and causes slight irritation to your opponent', 2, 5, 15, 1.05, NULL),
('First Aid', 'Light', 'Use your ranger first aid training to heal an ally', 5, 5, 5, NULL, 1.00),
('Healing', 'Holy', 'Slightly heals all party members regardless of distance', 8, 255, 255, NULL, 1.00),
('Ice Blast', 'Ice', 'Chills the air and sends icicles flying at multiple opponents', 10, 15, 15, 1.15, NULL),
('Blaze 2', 'Fire', 'A burning chasm erupts beneath your opponent', 12, 20, 5, 2.20, NULL);

INSERT INTO classes (skill_id, spell_id, stats_id, name, description, sub_weapon_id) VALUES
(1, 2, 2, 'Brute', 'A hulking menace with high attack and defense, moves very slowly and is not very bright', NULL),
(5, 1, 1, 'Fighter', 'Basic unit who hits things with sharp objects, all rounder with basically no magical ability', NULL),
(4, 3, 3, 'Flame Wizard', 'You guessed it! Casts strong spells but is physically very weak', NULL),
(2, 5, 4, 'Ranger', 'Long ranged attacker, also capable of weak healing spells', 7),
(6, 6, 3, 'Cleric', 'Holier than thou, but with their spiritual awareness they can heal your whole party', NULL),
(3, 4, 5, 'Rogue', 'Sneaky and devious, will steal anything for the right price', NULL);

INSERT INTO characters (class_id, name, age, race, level) VALUES
(1, 'Trogdor', 48, 'Orc', 1),
(2, 'Kort', 24, 'Dwarf', 1),
(3, 'Asmodeus', 67, 'Tortle', 1),
(4, 'Lethora', 4785, 'Wood Elf', 1),
(5, 'Sanctimony', NULL, 'Ancient Construct', 1),
(6, 'Anathema', 31, 'Bat-Like', 1);

INSERT INTO equipped_weapons (weapon_id, character_id) VALUES
(1, 2),
(4, 1),
(6, 3),
(3, 4),
(2, 5),
(5, 6);

-- Shows all character names
SELECT name FROM characters ORDER BY name;

-- Inserts characters into characters table
INSERT INTO characters (class_id, name, age, race, level) VALUES
(2, 'James', 18, 'Human', 1),
(1, 'Bobula', 15000000, 'Weird Blob Thingy', 20);

-- Shows all columns in the characters table for James and Bobula
SELECT * FROM characters WHERE name = 'James' OR name = 'Bobula';

-- Updates character with the name "James" with new age, race, name and class
UPDATE characters SET age = 374, race = 'High Elf', name = 'Gelthandril', class_id = 4 WHERE name = 'James';

-- Updates character with the name "Bobula" to new race
UPDATE characters SET race = 'Flying Cowboy Boot' WHERE name = 'Bobula';

-- Counts the number of characters assigned to each class, and returns only those with more than 1 character
SELECT 
    cl.name AS "Class Name",
    COUNT(c.class_id) AS "Number of Characters in Class"
FROM 
    characters c
    JOIN classes cl ON c.class_id = cl.class_id
GROUP BY
    cl.name
HAVING COUNT(c.class_id) >=2;

-- Deletes characters from characters table using two different WHERE clauses
DELETE FROM characters WHERE character_id = 8 OR name LIKE '%andril';

-- Shows everything from the characters table
SELECT * FROM characters;

-- Shows all weapons which are of a specific type and ranks them by power
SELECT * FROM weapons WHERE type = 'Melee' ORDER BY power DESC;

-- Complex join query showing multiple different columns from multiple different tables, with a subclause for two columns referring to the same foreign key, ordered by character name alphabetically
SELECT
    c.name AS "Character Name",
    c.level AS "Character Level",
    cl.name AS "Character Class",
    sp.name AS "Character Spell",
    sk.name AS "Character Skill",
    b.hp AS "Max Health",
    b.mp AS "Max Magic Power",
    w.name AS "Equipped Weapon",
    (SELECT w.name FROM weapons w WHERE cl.sub_weapon_id = w.weapon_id) AS "Sub Weapon"
FROM 
    equipped_weapons e
    JOIN weapons w ON w.weapon_id = e.weapon_id,
    characters c
    JOIN classes cl ON c.class_id = cl.class_id
    JOIN spells sp ON cl.spell_id = sp.spell_id
    JOIN skills sk ON cl.skill_id = sk.skill_id
    JOIN base_stats b ON cl.stats_id = b.stats_id
WHERE 
    e.character_id = c.character_id
ORDER BY 
    c.name;

-- Uses some basic math functions based on values across three different tables to calculate damage output, orders by highest physical attack damage
SELECT 
    c.name AS "Character Name",
    ROUND(b.atk + w.power) AS "Physical Attack Damage"
FROM 
    characters c
    JOIN classes cl ON cl.class_id = c.class_id
    JOIN base_stats b ON b.stats_id = cl.stats_id,
    equipped_weapons e
    JOIN weapons w ON w.weapon_id = e.weapon_id
WHERE 
    e.character_id = c.character_id
ORDER BY
    ROUND(b.atk + w.power) DESC;

-- Uses similar damage calculations as above but for attack spells, shows highest output possible for each character with offensive magic spells
SELECT
    c.name AS "Character Name",
    sp.name AS "Spell Name",
    sp.mp_cost AS "MP Cost",
    b.mp AS "Character MP",
    ROUND(b.mp / sp.mp_cost) AS "Total Uses",
    ROUND(sp.damage_factor * b.mag) AS "Spell Damage",
    ROUND((sp.damage_factor * b.mag)) * ROUND(b.mp / sp.mp_cost) AS "Total Damage Output"
FROM
    characters c
    JOIN classes cl ON cl.class_id = c.class_id
    JOIN spells sp ON sp.spell_id = cl.spell_id
    JOIN base_stats b ON b.stats_id = cl.stats_id
WHERE
    sp.damage_factor IS NOT NULL
ORDER BY 
    ROUND((sp.damage_factor * b.mag) *(b.mp / sp.mp_cost)) DESC;

-- Aggregate function count used to show number of each weapon type, uses group by to organise by type, ordered by count descending
SELECT COUNT(weapon_id) AS "Number of Weapons", type AS "With Type:" 
FROM weapons
GROUP BY type
ORDER BY COUNT(weapon_id) DESC;

-- A small query for characters who are older than or at a specific amount (150)
SELECT name AS "Possibly Immortal Characters", age AS "Characters Current Age (If Known)", race AS "Character Race"
FROM characters
WHERE age >=150 OR age IS NULL
ORDER BY age DESC;

-- Insert multiple values into the spells table
INSERT INTO spells (name, element, effect, mp_cost, range, area_of_effect, damage_factor, healing_factor) VALUES 
('Drain', 'Dark', 'Sucks the life blood from your foe, healing for half damage dealt', 6, 10, 5, 1.20, 0.60),
('Blazing Inferno', 'Fire', 'The highest level fire spell, brings a falling star upon your foe', 50, 50, 5, 8.00, NULL);

-- Query to select and fire spells (or similar) which have a damage factor over a specific value
SELECT name, effect, mp_cost FROM spells WHERE element LIKE 'F%' AND damage_factor > 2;

-- Count aggregate used to find any elements with multiple spells either equipped or not equipped
SELECT 
    element AS "Elements with Multiple Spells",
    COUNT(element) AS "Number of Spells in Element"
FROM spells
GROUP BY element
HAVING COUNT(element) >1;
