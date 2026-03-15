# Create a FastAPI Alembic Demo

This creates a FastAPI Alembic Demo.
Python packages are installed with `uv`

References
- https://pytutorial.com/fastapi-database-migrations-with-alembic/

## Building uv environment

```sh
uv add fastapi --extra=standard
uv add sqlalchemy alembic psycopg2-binary uvicorn
uv lock
```

