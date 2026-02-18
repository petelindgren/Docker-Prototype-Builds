# PostgresSql 17.8 Replication for Docker


## Changes for Postgres 17 Docker Build

### Postgres 17 Specific Changes

References: https://www.postgresql.org/docs/17/release-17.html

- Deprecate server variable `promote_trigger_file`

  **Why**: https://git.postgresql.org/gitweb/?p=postgresql.git;a=commitdiff;h=cd4329d93

  >Previously, an idle startup (recovery) process would wake up every 5
  >seconds to have a chance to poll for promote_trigger_file, even if that
  >GUC was not configured.  That promotion triggering mechanism was
  >effectively superseded by pg_ctl promote and pg_promote() a long time
  >ago.  There probably aren't many users left and it's very easy to change
  >to the modern mechanisms, so we agreed to remove the feature.
  >
  >This is part of a campaign to reduce wakeups on idle systems.

  **How**: 
  - https://www.postgresql.org/docs/16/recovery-config.html
  - https://www.postgresql.org/docs/16/release-16.html#RELEASE-16-MIGRATION

### Implementing Postgres 17 in Docker

- Remove deprecated `version` from `docker-compose.yml`

- Update `Dockerfile.reader` and `Dockerfile.writer`

  - Change Postgres Docker image from `bullseye` to `bookworm`
