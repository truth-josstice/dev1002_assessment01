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
    damage_factor FLOAT,
    healing_factor FLOAT
);

CREATE TABLE classes(
    class_id SERIAL PRIMARY KEY,
    stats_id INT NOT NULL REFERENCES base_stats(stats_id) ON DELETE CASCADE,
    skill_id INT NOT NULL REFERENCES skills(skill_id) ON DELETE CASCADE,
    spell_id INT NOT NULL REFERENCES spells(spell_id) ON DELETE SET NULL,
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
('Shortsword', 'Melee', 5, 5, 'A sturdy but blunt beginner shortsword'),
('Spear', 'Melee', 4, 10, 'A wooden rod with a sharp metal point, can reach further than a lance'),
('Bow', 'Ranged', 3, 40, 'A shortbow with a loose string, weak but beginner friendly'),
('Axe', 'Melee', 6, 5, 'A heavy blunt axe, more likely to crush than cut'),
('Dagger', 'Thrown', 2, 20, 'A thrown dagger, very weak but maybe you could hit a vital point'),
('Staff', 'Melee', 1, 5, 'Incredibly weak, wizards use bonk attack...it is not very effective');

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
(10, 30, 1, 10, 7, 3),
(15, 20, 5, 5, 8, 6),
(12, 12, 7, 3, 6, 5);

INSERT INTO spells (name, element, effect, mp_cost, range, damage_factor, healing_factor) VALUES
('Sharpen', 'Buff', 'Magically sharpens sword, damage plus 2', 3, 0, NULL, NULL),
('Roar', 'Debuff', 'May scare opponent, 5% chance to lower defence', 1, 10, NULL, NULL),
('Blaze', 'Fire', 'Sets fire to your opponent', 6, 20, 1.30, NULL),
('Darkness', 'Dark', 'Blinds and causes slight irritation to your opponent', 2, 5, 1.20, NULL),
('First Aid', 'Light', 'Use your ranger first aid training to heal an ally', 5, 5, NULL, 1.00),
('Healing', 'Holy', 'Slightly heals all party members regardless of distance', 8, 255, NULL, 1.00);

INSERT INTO classes (skill_id, spell_id, stats_id, name, description) VALUES
('Brute', 'A hulking menace with high attack and defense, moves very slowly and is not very bright'),
('Fighter', 'Basic unit who hits things with sharp objects, all rounder with basically no magical ability'),
('Wizard', 'You guessed it! Casts strong spells but is physically very weak'),
('Ranger', 'Long ranged attacker, also capable of weak healing spells'),
('Cleric', 'Holier than thou, but with their spiritual awareness they can heal your whole party'),
('Rogue', 'Sneaky and devious, will steal anything for the right price');