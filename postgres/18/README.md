# PostgresSql 18.1 Replication for Docker


## Changes for Postgres 18 Docker Build

### Postgres 18 Specific Changes

References: https://www.postgresql.org/docs/18/release-18.html

- No Change Needed

- Between 17 and 18 postgres writer changed from

  - 17
    >/var/lib/postgresql/data

  - 18
    >/var/lib/postgresql/18/docker

  For better explanation:
  Ref: https://www.pinepods.online/docs/Troubleshooting/PostgreSQL-18-Docker-Issue


### Implementing Postgres 18 in Docker

- No Change Needed
Error: in 18+, these Docker images are configured to store database data in a

       format which is compatible with "pg_ctlcluster" (specifically, using

       major-version-specific directory names).  This better reflects how

       PostgreSQL itself works, and how upgrades are to be performed.


       See also https://github.com/docker-library/postgres/pull/1259


       Counter to that, there appears to be PostgreSQL data in:

         /var/lib/postgresql/data (unused mount/volume)


       This is usually the result of upgrading the Docker image without

       upgrading the underlying database using "pg_upgrade" (which requires both

       versions).


       The suggested container configuration for 18+ is to place a single mount

       at /var/lib/postgresql which will then place PostgreSQL data in a

       subdirectory, allowing usage of "pg_upgrade --link" without mount point

       boundary issues.


       See https://github.com/docker-library/postgres/issues/37 for a (long)

       discussion around this process, and suggestions for how to do so.