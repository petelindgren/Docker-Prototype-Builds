#!/bin/bash
set -e
EXISTING_ROLE=`psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tXAc "SELECT 1 FROM pg_roles WHERE rolname='$PUB_SUB_USER'"`
if [ "${EXISTING_ROLE}" != 1 ]; then
echo "Create new user '$PUB_SUB_USER' for logical replication"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE USER $PUB_SUB_USER REPLICATION ENCRYPTED PASSWORD '$PUB_SUB_PASSWORD';
GRANT ALL PRIVILEGES ON DATABASE music_artists TO $PUB_SUB_USER;
GRANT ALL PRIVILEGES ON DATABASE music_discography TO $PUB_SUB_USER;
\c music_artists;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO $PUB_SUB_USER;
\c music_discography;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO $PUB_SUB_USER;
EOSQL
else
echo "Use existing user '$PUB_SUB_USER' for logical (pub-sub) replication"
fi


# https://www.postgresql.org/docs/current/sql-createsubscription.html
# wal_level must be 'logical' for pub-sub.  'logical' also support standard replication
# replace 'wal_level = replica' with 'wal_level = logical'
echo "Update postgresql.conf so 'wal_level = logical'"
sed -i 's/wal_level = replica/wal_level = logical/g' ${PGDATA}/postgresql.conf
