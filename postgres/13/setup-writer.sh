#!/bin/bash
echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
set -e
EXISTING_ROLE=`psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tXAc "SELECT 1 FROM pg_roles WHERE rolname='$PG_REP_USER'"`
if [ "${EXISTING_ROLE}" != 1 ]; then
echo "Create new user '$PG_REP_USER' for replication"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE USER $PG_REP_USER REPLICATION LOGIN CONNECTION LIMIT 100 ENCRYPTED PASSWORD '$PG_REP_PASSWORD';
EOSQL
else
echo "Use existing user '$PG_REP_USER' for replication"
fi
cat >> ${PGDATA}/postgresql.conf <<EOF
wal_level = replica
archive_mode = on
archive_command = 'cd .'
max_wal_senders = 8
wal_keep_size = 128
hot_standby = on
EOF