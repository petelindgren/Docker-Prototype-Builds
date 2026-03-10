CREATE DATABASE music;

\c music;

CREATE TABLE artists(
 id SERIAL PRIMARY KEY,
 name VARCHAR(255) NOT NULL
);

CREATE TABLE band_members(
 id SERIAL PRIMARY KEY,
 artist_id INTEGER NOT NULL,
 first_name VARCHAR(255) NOT NULL,
 last_name VARCHAR(255) NOT NULL,
 CONSTRAINT fk_artist
 FOREIGN KEY (artist_id) REFERENCES artists (id)
);

CREATE TABLE albums(
 id SERIAL PRIMARY KEY,
 artist_id INTEGER NOT NULL,
 name VARCHAR(255) NOT NULL,
 release_year INTEGER
);

CREATE TABLE songs(
 id SERIAL PRIMARY KEY,
 album_id INTEGER NOT NULL,
 name VARCHAR NOT NULL,
 length FLOAT NOT NULL,
 track INTEGER NULL,
 CONSTRAINT fx_album
 FOREIGN KEY (album_id) REFERENCES albums (id)
);
