# PostgresSql 13.18 Replication for Docker


## Changes for Postgres 13 Docker Build

### Postgres 13 Specific Changes

References: https://www.postgresql.org/docs/13/release-13.html

- Replace `wal_keep_segments` with `wal_keep_size`

  **Why**: https://www.postgresql.org/docs/13/release-13.html#id-1.11.6.24.4

  >Rename configuration parameter `wal_keep_segments` to `wal_keep_size` (Fujii Masao) §
  >This determines how much WAL to retain for standby servers. It is specified in megabytes, rather than number of files as with the old parameter.

  **How**: https://www.postgresql.org/docs/13/release-13.html#id-1.11.6.24.4

  >If you previously used `wal_keep_segments`, the following formula will give you an approximately equivalent setting:

  ```sh
  wal_keep_size = wal_keep_segments * wal_segment_size (typically 16MB)
  ```

### Implementing Postgres 13 in Docker

- Update `setup-writer.sh`

  - Change `wal_keep_segments = 8` to `wal_keep_size = 128`
