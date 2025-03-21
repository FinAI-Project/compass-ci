FROM python:3.12-slim-bookworm

WORKDIR /app

COPY requirements.txt .

ENV VIRTUAL_ENV="/app/.venv"
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends git make; \
    git config --system --add safe.directory '*'; \
    python -m venv .venv; \
    pip install -r requirements.txt; \
    pip cache purge; \
    rm -rf /var/lib/apt/lists/*;
