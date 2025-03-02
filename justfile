default:
  @just --list

# Initialize a new project
init:
  git init
  git commit --allow-empty -m "Initial commit"
  git add --all
  git commit -m "🚀 Initialized project using https://github.com/tsvikas/python-template"
  @just update-deps
  git add --all
  git commit -m "⬆️ Updated project dependencies"
  @just prepare

# Update all dependencies
update-deps:
  uv sync --upgrade
  uv run pre-commit autoupdate -j "$(nproc)"

# Initialize the project after cloning
prepare:
  uv run pre-commit install

# Run all code quality checks and tests
check:
  # pre-commit includes everything except mypy and pytest
  uv run pre-commit run --all-files
  uv run mypy
  uv run pytest

format:
  uv run black .

lint:
  uv run codespell
  uv run ruff check
  uv run mypy

test:
  uv run pytest
