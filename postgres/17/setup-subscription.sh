#!/bin/bash
set -e

echo "Running setup-subscription.sh"

echo "Create SUBSCRIPTIONs"

echo "Use user '$PUB_SUB_USER' to create new subscription for logical replication."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
\c music;

CREATE SUBSCRIPTION sub_artists
CONNECTION 'host=pg_writer port=5432 dbname=music_artists user=$PUB_SUB_USER password=$PUB_SUB_PASSWORD'
PUBLICATION pub_artists
WITH (copy_data = true);

CREATE SUBSCRIPTION sub_discography
CONNECTION 'host=pg_writer port=5432 dbname=music_discography user=$PUB_SUB_USER password=$PUB_SUB_PASSWORD'
PUBLICATION pub_discography
WITH (copy_data = true);
EOSQL

echo "Created SUBSCRIPTIONs"