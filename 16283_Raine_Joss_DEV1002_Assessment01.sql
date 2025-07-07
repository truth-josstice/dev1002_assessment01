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
    description VARCHAR(100) NOT NULL
);

CREATE TABLE skills(
    skill_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    description VARCHAR(100) NOT NULL,
    max_uses VARCHAR(16)
);

CREATE TABLE spells(
    spell_id SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    element VARCHAR(16) NOT NULL,
    effect VARCHAR(100) NOT NULL,
    mp_cost INT NOT NULL,
    range INT NOT NULL,
    damage_factor FLOAT,
    healing_factor FLOAT
);

CREATE TABLE classes(
    class_id SERIAL PRIMARY KEY,
    skill_id INT NOT NULL REFERENCES skills(skill_id) ON DELETE CASCADE,
    spell_id INT NOT NULL REFERENCES spells(spell_id) ON DELETE SET NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    hp_mod FLOAT NOT NULL,
    mp_mod FLOAT NOT NULL,
    atk_mod FLOAT NOT NULL,
    mag_mod FLOAT,
    def_mod FLOAT NOT NULL,
    mov_mod INT
);

CREATE TABLE characters(
    character_id SERIAL PRIMARY KEY,
    class_id INT NOT NULL REFERENCES classes(class_id) ON DELETE SET NULL,
    stats_id INT NOT NULL REFERENCES base_stats(stats_id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    age INT,
    race VARCHAR(32) NOT NULL,
    level INT CHECK (level <= 20) NOT NULL
);

CREATE TABLE base_stats(
    stats_id SERIAL PRIMARY KEY,
    character_id INT NOT NULL REFERENCES characters(character_id) ON DELETE CASCADE,
    hp INT NOT NULL,
    mp INT NOT NULL,
    atk INT NOT NULL,
    mag INT NOT NULL,
    mov INT CHECK (mov <= 10) NOT NULL
);

CREATE TABLE equipped_weapons(
    equipped_id SERIAL PRIMARY KEY,
    weapon_id INT NOT NULL REFERENCES weapons(weapon_id) ON DELETE CASCADE,
    character_id INT NOT NULL REFERENCES characters(character_id) ON DELETE CASCADE
);

INSERT INTO weapons (name, type, power, range, description) VALUES
("Shortsword", "Melee", 5, 5, "A sturdy but blunt beginner's shortsword"),
("Spear", "Melee", 4, 10, "A wooden rod with a sharp metal point, can reach further than a lance"),
("Bow", "Ranged", 3, 40, "A shortbow with a loose string, weak but beginner friendly"),
("Axe", "Melee", 6, 5, "A heavy blunt axe, more likely to crush than cut"),
("Dagger", "Thrown", 2, 20, "A thrown dagger, very weak but maybe you could hit a vital point"),
("Staff", "Magical", 1, 5, "Incredibly weak, wizards use bonk attack...it's not very effective");

INSERT INTO skills (name, description, max_uses) VALUES
("Oomph", "Orcish strength, boosts your defence for three rounds at the start of battle", "N/A"),
("Prayer", "Before heading into a dungeon, pray to ascertain the difficulty of enemies", "Unlimited"),
("Sneak", "Sneak past an enemy during battle, allowing the party to escape", "Five"),
("Undermine", "Uses wizards intellect to confuse a guardian", "Three"),
("Blitz", "Attacks twice with a melee weapon", "Once per battle");

INSERT INTO base_stats (hp, mp, atk, mag, def, mov) VALUES
