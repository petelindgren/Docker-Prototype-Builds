#!/usr/bin/env bash
if [ ! -s "$PGDATA/PG_VERSION" ]; then
# Do not use a .pgpass file in production because of security concerns
# One alternative is Trust Authentication https://www.postgresql.org/docs/11/auth-trust.html
echo "*:*:*:$PG_REP_USER:$PG_REP_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass
until ping -c 1 -W 1 pg_writer
do
echo "Waiting for writer to ping..."
sleep 1s
done
until pg_basebackup -h pg_writer -D ${PGDATA} -U ${PG_REP_USER} -vP -W
do
echo "Waiting for writer to connect..."
sleep 1s
done
echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"
set -e
cat > ${PGDATA}/recovery.conf <<EOF
standby_mode=on
primary_conninfo = 'host=pg_writer port=5432 user=$PG_REP_USER password=$PG_REP_PASSWORD'
trigger_file = '/tmp/touch_me_to_promote_to_me_writer'
EOF
chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi
sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf
exec "$@"