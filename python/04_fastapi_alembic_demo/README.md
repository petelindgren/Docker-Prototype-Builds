# Create a FastAPI Alembic Demo

This creates a FastAPI Alembic Demo.
Python packages are installed with `uv`

References
- https://pytutorial.com/fastapi-database-migrations-with-alembic/

## Building uv environment

- Add Python packages to `uv`

  ```sh
  uv add fastapi --extra=standard
  uv add sqlalchemy alembic psycopg2-binary uvicorn
  uv lock
  ```

- Add alembic

  ```sh
  alembic init alembic
  ```

  creates
  - alembic.ini
  - alembic/env.py
  - alembic/script.py.mako
  - alembid/README


- Create alembic migration

  ```sh
  alembic revision --autogenerate -m "Create users table"
  ```
