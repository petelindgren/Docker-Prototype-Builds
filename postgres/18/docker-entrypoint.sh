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

echo "Reader is connected to Writer"

echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"

set -e

# PostgreSQL 12 eliminates recovery.conf and adds configuration for replicas and standbys to postgresql.conf
# https://www.postgresql.org/docs/12/recovery-config.html
# https://www.postgresql.org/docs/12/hot-standby.html
cat >> ${PGDATA}/postgresql.conf <<EOF
hot_standby = on
primary_conninfo = 'host=$PG_WRITER_HOST port=${PG_WRITER_PORT:-5432} user=$PG_REP_USER password=$PG_REP_PASSWORD'
EOF

# PostgreSQL 12 replaced `standby_mode` with the `standy.signal` file in the PGDATA directory 
touch ${PGDATA}/standby.signal

# To fix this error:
#   postgres: could not access directory "/var/lib/postgresql/18/docker": Permission denied
# Change directory permissions from this:
#   drwx------ 3 root     root
# To this:
#   drwxr-xr-x 3 root     root
echo "Update postgresql/18 directory so is is executable"
chmod 755 /var/lib/postgresql/18

echo "Update permissions on $PGDATA"
chown postgres:postgres ${PGDATA} -R
chmod 700 ${PGDATA} -R

fi

# sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf

exec "$@"