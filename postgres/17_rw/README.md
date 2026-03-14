# PostgresSql 17.8 Replication for Docker


## Changes for Postgres 17 Docker Build

### Postgres 17 Specific Changes

References: https://www.postgresql.org/docs/17/release-17.html

- No Change Needed

### Implementing Postgres 17 in Docker

- Remove deprecated `version` from `docker-compose.yml`

- Update `Dockerfile.reader` and `Dockerfile.writer`

  - Change Postgres Docker image from `bullseye` to `bookworm`
    The `bookworm` image is still based on Debian linux
    so we can continue to use the `gosu` command.