FROM python:3.13-bookworm

# Install uv
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Install thep project
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#installing-a-project

# Copy the project into the image
COPY . /app

# Disable development dependencies
ENV UV_NO_DEV=1

# Sync the project into a new environment, asserting the lockfile is up to date
WORKDIR /app
RUN uv sync --locked


CMD ["uv", "run", "main.py"]
