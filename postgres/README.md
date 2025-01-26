# Docker Postgres Builds

These Docker builds are for Postgres configured for Read-Write Replication

## Version Changes

### Postgres 9
Postgres 9 is the original version based on this [blog post](https://medium.com/@2hamed/replicating-postgres-inside-docker-the-how-to-3244dc2305be).


### Postgres 10 Changes

- Use [Hot Standby](https://wiki.postgresql.org/wiki/Hot_Standby) as ReadOnly replica

    >Hot Standby is the name for the capability to run queries on a database that is currently performing archive recovery. Log Shipping replication allows you to create one or more standby nodes that are replicas of the primary node (or master node). Standby nodes can then be used for read-only query access.

    mey Do not configure as [Warm Standby](https://wiki.postgresql.org/wiki/Warm_Standby)

  - https://www.postgresql.org/docs/12/hot-standby.html


### Postgres 11 Changes


### Postgres 12 Changes


### Postgres 13 Changes


### Postgres 14 Changes


### Postgres 15 Changes


### Postgres 16 Changes

