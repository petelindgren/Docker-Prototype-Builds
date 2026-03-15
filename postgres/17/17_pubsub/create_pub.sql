\c music_artists;
CREATE PUBLICATION pub_artists FOR TABLE artists, band_members;

\c music_discography;
CREATE PUBLICATION pub_discography FOR TABLE albums, songs;