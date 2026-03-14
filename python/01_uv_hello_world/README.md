# Introduction to Managing Python Projects With uv

This folder contains an introductory Python project using UV



- What: Introduce managing Python projects with `uv`
  - https://docs.astral.sh/uv/

- Why: `uv` is a new Python package manager built in Rust that is much faster than `pip` or `pdm` or `poetry`.
  - it is 10-100x faster than `pip`
- How:
  - Based on introductory tutorial at https://docs.astral.sh/uv/guides/projects/#creating-a-new-project
  - Add additional Python libraries that will be needed in future prototype builds
  - Demonstrate how `uv` can be used to replace `pip` and `pipenv`
  - Create `pyproject.toml` file with Python packages

## Changes from previous example
- N/A

## Building Docker Image and Running Docker Container
There is no Dockerfile in this example.  That comes next

### Create

-   Add packages to `pyproject.toml`

    ```sh
    uv add fastapi sqlalchemy pydantic alembic tenacity
    ```

-   Add development environment only packages to `pyproject.toml`

    ```sh
    uv add --dev pytest ruff coverage
    ```

-   Create `uv.lock` file from `pyproject.toml` packages
    ```sh
    uv lock
    ```

-   Build a virtual environment to `.venv`

    ```sh
    uv sync
    ```

-   Activate virtual environment

    ```sh
    source .venv/bin/activate
    ```

### Run the Python app

-   Run this command:

    ```sh
    uv run main.py
    ```

    and this should be printed to the console:

    ```text
    Hello World!
    ```
