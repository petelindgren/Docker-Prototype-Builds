# PostgresSql 18.1 Replication for Docker


## Changes for Postgres 18 Docker Build

### Postgres 18 Specific Changes

References: https://www.postgresql.org/docs/18/release-18.html

- Between 17 and 18 postgres writer changed from

  - 17
    >/var/lib/postgresql/data

  - 18
    >/var/lib/postgresql/18/docker

  For better explanation:
  Ref: https://www.pinepods.online/docs/Troubleshooting/PostgreSQL-18-Docker-Issue


### Implementing Postgres 18 in Docker

- Update `docker-entrypoint.sh` to intentionally set xwr permissions on DB Reader

    ```sh
    chmod 755 /var/lib/postgresql/18
    ```

  or postgres will not start on the DB reader for this reason:

    >postgres: could not access directory "/var/lib/postgresql/18/docker": Permission denied
