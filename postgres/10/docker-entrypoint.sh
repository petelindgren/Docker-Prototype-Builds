#!/usr/bin/env bash

if [ ! -s "$PGDATA/PG_VERSION" ]; then
# Do not use a .pgpass file in production because of security concerns
echo "*:*:*:$PG_REP_USER:$PG_REP_PASSWORD" > ~/.pgpass

chmod 0600 ~/.pgpass

until ping -c 1 -W 1 ${PG_WRITER_HOST:?missing environment variable. PG_WRITER_HOST must be set}
    do
        echo "Waiting for writer to ping..."
        sleep 1s
done
until pg_basebackup -h ${PG_WRITER_HOST} -D ${PGDATA} -U ${PG_REP_USER} -vP -W
    do
        echo "Waiting for writer to connect..."
        sleep 1s
done

echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"

set -e

# PostgreSQL 11 and below used a configuration file named recovery.conf to manage replicas and standbys.
# https://www.postgresql.org/docs/12/recovery-config.html
# https://www.postgresql.org/docs/12/hot-standby.html
cat > ${PGDATA}/recovery.conf <<EOF
standby_mode = on
primary_conninfo = 'host=$PG_WRITER_HOST port=${PG_WRITER_PORT:-5432} user=$PG_REP_USER password=$PG_REP_PASSWORD'
trigger_file = '/tmp/touch_me_to_promote_to_me_writer'
EOF

chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R

fi

sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf 

exec "$@"
