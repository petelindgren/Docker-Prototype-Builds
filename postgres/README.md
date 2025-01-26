# Docker Postgres Builds

These Docker builds are for Postgres configured for Read-Write Replication

## Version Changes

### Postgres 9
Postgres 9 is the original version based on this [blog post](https://medium.com/@2hamed/replicating-postgres-inside-docker-the-how-to-3244dc2305be).


### Postgres 10 Specific Changes

References: https://www.postgresql.org/docs/10/release-10.html

- Configure ReadOnly replica as **Hot Standby**

  **Why**: https://wiki.postgresql.org/wiki/Hot_Standby

  >Hot Standby is the name for the capability to run queries on a database that is currently performing archive recovery. Log Shipping replication allows you to create one or more standby nodes that are replicas of the primary node (or master node). Standby nodes can then be used for read-only query access.

  >Do not configure as [Warm Standby](https://wiki.postgresql.org/wiki/Warm_Standby)

  **How**:
  - https://www.postgresql.org/docs/12/hot-standby.html
  - https://www.postgresql.org/docs/10/runtime-config-wal.html

    >`wal_level` determines how much information is written to the WAL. The default value is `replica`, which writes enough data to support WAL archiving and replication, including running read-only queries on a standby server. `minimal` removes all logging except the information required to recover from a crash or immediate shutdown. Finally, `logical` adds information necessary to support logical decoding. Each level includes the information logged at all lower levels. This parameter can only be set at server start.
    >
    >In releases prior to 9.6, this parameter also allowed the values `archive` and `hot_standby`. These are still accepted but mapped to `replica`.


### Postgres 11 Specific Changes

References: https://www.postgresql.org/docs/11/release-11.html

- No Change Needed


### Postgres 12 Specific Changes

References: https://www.postgresql.org/docs/12/release-12.html

- Move `recovery.conf` settings to `postgresql.conf`

  **Why**: https://www.postgresql.org/docs/12/release-12.html#id-1.11.6.28.4

  >Move recovery.conf settings into postgresql.conf (Masao Fujii, Simon Riggs, Abhijit Menon-Sen, Sergei Kornilov) §
  >
  >`recovery.conf` is no longer used, and the server will not start if that file exists. `recovery.signal` and `standby.signal` files are now used to switch into non-primary mode. The `trigger_file` setting has been renamed to `promote_trigger_file`. The standby_mode setting has been removed.

  **How**:
  - https://www.postgresql.org/docs/12/recovery-config.html

    >The server will not start if a `recovery.conf` exists.
    >The `trigger_file` setting has been renamed to [`promote_trigger_file`](https://www.postgresql.org/docs/12/runtime-config-replication.html#GUC-PROMOTE-TRIGGER-FILE).
    >The `standby_mode` setting has been removed. A `standby.signal` file in the data directory is used instead.  See [Standby Server Operation](https://www.postgresql.org/docs/12/warm-standby.html#STANDBY-SERVER-OPERATION) for details.


### Postgres 13 Specific Changes

References: https://www.postgresql.org/docs/13/release-13.html

- No Change Needed


### Postgres 14 Specific Changes


### Postgres 15 Specific Changes


### Postgres 16 Specific Changes

