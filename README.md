# Docker Prototype Builds

These examples demonstrate how to use Docker to build different environments.

The folder structure is organized by the infrastructure that is being explored.
Nested sub-folders contain version specific Docker environments.

## Build Types

- Postgres with Read-Write Replication
  - Use [Hot Standby](https://wiki.postgresql.org/wiki/Hot_Standby) as ReadOnly replica

    >Hot Standby is the name for the capability to run queries on a database that is currently performing archive recovery. Log Shipping replication allows you to create one or more standby nodes that are replicas of the primary node (or master node). Standby nodes can then be used for read-only query access.

    mey Do not configure as [Warm Standby](https://wiki.postgresql.org/wiki/Warm_Standby)

  - https://www.postgresql.org/docs/12/hot-standby.html
