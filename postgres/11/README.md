# PostgresSql 11.22 Replication for Docker


## Changes for Postgres 11 Docker Build

### Postgres 11 Specific Changes

References: https://www.postgresql.org/docs/11/release-11.html

- No Change Needed

### Implementing Postgres 11 in Docker

- Update `Dockerfile.writer`

  - Add `configure-rw-postgres.sql` to add custom configuration.
  
    ```
    COPY ./configure-rw-postgres.sql /docker-entrypoint-initdb.d/configure-rw-postgres.sql
    ```
