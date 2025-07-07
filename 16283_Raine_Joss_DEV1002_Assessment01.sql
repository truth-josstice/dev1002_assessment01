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

CREATE TABLE base_stats(
    stats_id SERIAL PRIMARY KEY,
    hp INT NOT NULL,
    mp INT NOT NULL,
    atk INT NOT NULL,
    mag INT NOT NULL,
    mov INT CHECK (mov <= 10) NOT NULL
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
    def_mod FLOAT NOT NULL
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


