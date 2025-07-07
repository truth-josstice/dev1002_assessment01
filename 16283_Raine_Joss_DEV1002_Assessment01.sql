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








