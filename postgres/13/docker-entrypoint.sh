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

# postgres12 eliminates recovery.conf and adds standby configuration to postgresql.conf
# https://www.postgresql.org/docs/12/hot-standby.html
cat >> ${PGDATA}/postgresql.conf <<EOF
hot_standby = on
promote_trigger_file = '/tmp/touch_me_to_promote_to_me_writer'
primary_conninfo = 'host=$PG_WRITER_HOST port=${PG_WRITER_PORT:-5432} user=$PG_REP_USER password=$PG_REP_PASSWORD'
EOF

# A standy.signal file in the PGDATA directory replaces `standby_mode`
touch ${PGDATA}/standby.signal

chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi

# sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf

exec "$@"