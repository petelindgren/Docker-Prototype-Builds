# PostgresSql 16.6 Replication for Docker


## Changes for Postgres 16 Docker Build

### Postgres 16 Specific Changes

References: https://www.postgresql.org/docs/16/release-16.html

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

### Implementing Postgres 16 in Docker

- Update `docker-entrypoint.sh`

  - Remove deprecated `promote_trigger_file`
