# PostgresSql 12.22 Replication for Docker


## Changes for Postgres 12 Docker Build

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

### Implementing Postgres 12 in Docker

- Update `docker-entrypoint.sh`

  - Replace `standby_mode` with a `standby.signal` file

    ```sh
    touch ${PGDATA}/standby.signal
    ```

  - Change configuration file from `recovery.conf` to `postgresql.conf`:
  - Change `standby_mode = on` to `hot_standby = on`
  - Change `trigger_file` to `promote_trigger_file`
