-- See https://docs.docker.com/guides/pre-seeding/

CREATE DATABASE music_artists;

\c music_artists;

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

INSERT INTO artists(id,name) VALUES 
 (1,'Pink Floyd'),
 (2,'The Beatles'),
 (3,'Metallica')
ON CONFLICT (id) DO NOTHING;

INSERT INTO band_members(id, artist_id, first_name, last_name) VALUES
 (1,1,'Roger','Waters'),
 (2,1,'Nick','Mason'),
 (3,1,'Richard','Wright'),
 (4,1,'Syd','Barrett'),
 (5,1,'David','Gilmour')
ON CONFLICT (id) DO NOTHING;

-- Reset Auto-Increments Sequences (this step is also required after AWS DMS)
SELECT setval('artists_id_seq', (SELECT MAX(id)+1 FROM artists));
SELECT setval('band_members_id_seq', (SELECT MAX(id)+1 FROM band_members));

CREATE DATABASE music_discography;

\c music_discography;

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

INSERT INTO albums(id,artist_id,name,release_year) VALUES
 (1,1,'A Saucerful of Secrets',1968),
 (2,1,'Meddle',1969),
 (3,1,'The Dark Side of the Moon',1973),
 (4,1,'Wish You Were Here',1975),
 (5,1,'Animals',1977),
 (6,1,'The Wall (Disc 1)',1979),
 (7,1,'The Wall (Disc 2)',1979),
 (8,1,'A Momentary Lapse of Reason',1987),
 (9,3,'Master of Puppets',NULL),
 (10,3,'...And Justice for All',1988),
 (11,3,'Death Magnetic',2008)
ON CONFLICT (id) DO NOTHING;

INSERT INTO songs(id,album_id,name,length,track) VALUES
 (1,1,'Let There Be More Light',5+(38/60),1),
 (2,1,'Remember A Day',4+(34/60),2),
 (3,1,'Set The Controls For The Heart Of The Sun',5+(28/60),3),
 (4,1,'Corporal Clegg',4+(13/60),4),
 (5,1,'A Saucerful Of Secrets',11+(57/60),5),
 (6,1,'See-Saw',4+(37/60),6),
 (7,1,'Jugband Blues',2+(59/60),7),
 (8,2,'One of These Days',5+(56/60),1),
 (9,2,'A Pillow of Winds',5+(13/60),2),
 (10,2,'Fearless',6+(08/60),3),
 (11,2,'San Tropez',3+(43/60),4),
 (12,2,'Seamus',2+(15/60),5),
 (13,2,'Echoes',22+(28/60),6),
 (14,3,'Speak To Me',1+(14/60),1),
 (15,3,'Breathe',2+(46/60),2),
 (16,3,'On The Run',3+(35/60),3),
 (17,3,'Time',7+(05/60),4),
 (18,3,'The Great Gig In The Sky',4+(44/60),5),
 (19,3,'Money',6+(32/60),6),
 (20,3,'Us And Them',7+(41/60),7),
 (21,3,'Any Colour You Like',3+(26/60),8),
 (22,3,'Brain Damage',3+(50/60),9),
 (23,3,'Eclipse',2+(03/60),10),
 (24,4,'Shine On You Crazy Diamond (Parts I - V)',13+(38/60),1),
 (25,4,'Welcome To The Machine',7+(30/60),2),
 (26,4,'Have A Cigar',5+(25/60),3),
 (27,4,'Wish You Were Here',5+(17/60),4),
 (28,4,'Shine On You Crazy Diamond (Parts VI - X)',12+(29/60),5),
 (29,5,'Pigs On The Wing (Part One)',1+(25/60),1),
 (30,5,'Dogs',17+(05/60),2),
 (31,5,'Pigs (Three Different Ones)',11+(26/60),3),
 (32,5,'Sheep',10+(18/60),4),
 (33,5,'Pigs On The Wing (Part Two)',1+(25/60),5),
 (34,6,'In the Flesh?',3+(19/60),1),
 (35,6,'The Thin Ice',2+(30/60),2),
 (36,6,'Another Brick in the Wall, Part 1',3+(10/60),3),
 (37,6,'The Happiest Days of Our Lives',1+(50/60),4),
 (38,6,'Another Brick in the Wall, Part 2',3+(59/60),5),
 (39,6,'Mother',5+(36/60),6),
 (40,6,'Goodbye Blue Sky',2+(47/60),7),
 (41,6,'Empty Spaces',2+(09/60),8),
 (42,6,'Young Lust',3+(31/60),9),
 (43,6,'One of My Turns',3+(36/60),10),
 (44,6,'Don''t Leave Me Now',4+(16/60),11),
 (45,6,'Another Brick in the Wall, Part 3',1+(15/60),12),
 (46,6,'Goodbye Cruel World',1+(15/60),13),
 (47,7,'Hey You',4+(41/60),1),
 (48,7,'Is There Anybody Out There?',2+(40/60),2),
 (49,7,'Nobody Home',3+(25/60),3),
 (50,7,'Vera',1+(33/60),4),
 (51,7,'Bring the Boys Back Home',1+(27/60),5),
 (52,7,'Comfortably Numb',6+(26/60),6),
 (53,7,'The Show Must Go On',1+(36/60),7),
 (54,7,'In the Flesh',4+(17/60),8),
 (55,7,'Run Like Hell',4+(24/60),9),
 (56,7,'Waiting for the Worms',3+(58/60),10),
 (57,7,'Stop',0+(30/60),11),
 (58,7,'The Trial',5+(20/60),12),
 (59,7,'Outside the Wall',1+(43/60),13),
 (60,8,'Signs Of Life',4+(24/60),1),
 (61,8,'Learning To Fly',4+(53/60),2),
 (62,8,'The Dogs Of War',6+(09/60),3),
 (63,8,'One Slip',5+(07/60),4),
 (64,8,'On The Turning Away',5+(42/60),5),
 (65,8,'Yet Another Movie - Round and Around',7+(28/60),6),
 (66,8,'A New Machine - Part 1',1+(46/60),7),
 (67,8,'Terminal Frost',6+(17/60),8),
 (68,8,'A New Machine - Part 2',0+(39/60),9),
 (69,8,'Sorrow',8+(47/60),10),
 (36,4,'Battery',5+(13/60),1),
 (37,4,'Master of Puppets',8+(35/60),2),
 (38,4,'The Thing That Should Not Be',6+(36/60),3),
 (39,4,'Welcome Home (Sanitarium)',6+(27/60),4),
 (40,4,'Disposable Heroes',8+(17/60),5),
 (41,4,'Leper Messiah',5+(40/60),6),
 (42,4,'Orion',8+(27/60),7),
 (43,4,'Damage Inc.',5+(32/60),8),
 (44,5,'Blackened',6+(41/60),1),
 (45,5,'...And Justice for All',9+(47/60),2),
 (46,5,'Eye of the Beholder',6+(30/60),3),
 (47,5,'One',7+(27/60),4),
 (48,5,'The Shortest Straw',6+(36/60),5),
 (49,5,'Harvester of Sorrow',5+(46/60),6),
 (50,5,'The Frayed Ends of Sanity',7+(44/60),7),
 (51,5,'To Live Is to Die',9+(49/60),8),
 (52,5,'Dyers Eve',5+(13/60),9),
 (53,6,'That Was Just Your Life',7+(08/60),1),
 (54,6,'The End of the Line',7+(52/60),2),
 (55,6,'Broken Beat & Scarred',6+(25/60),3),
 (56,6,'The Day That Never Comes',7+(56/60),4),
 (57,6,'All Nightmare Long',7+(58/60),5),
 (58,6,'Cyanide',6+(40/60),6),
 (59,6,'The Unforgiven III',7+(47/60),7),
 (60,6,'The Judas Kiss',8+(01/60),8),
 (61,6,'Suicide & Redemption',9+(58/60),9),
 (62,6,'My Apocalypse',5+(01/60),10)
ON CONFLICT (id) DO NOTHING;

-- Reset Auto-Increments Sequences (this step is also required after AWS DMS)
SELECT setval('albums_id_seq', (SELECT MAX(id)+1 FROM albums));
SELECT setval('songs_id_seq', (SELECT MAX(id)+1 FROM songs));
