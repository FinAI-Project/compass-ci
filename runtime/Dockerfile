FROM python:3.12-slim-bookworm

ARG RUNTIME_USER=compass

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends git make curl rsync; \
    useradd $RUNTIME_USER; \
    rm -rf /var/lib/apt/lists/*;

USER $RUNTIME_USER
WORKDIR /home/$RUNTIME_USER
COPY . .
SHELL ["/bin/bash", "-c"]
RUN set -e; \
    python -m venv .venv; \
    source .venv/bin/activate; \
    pip install --no-cache -r requirements.txt;

ENV VIRTUAL_ENV="/home/$RUNTIME_USER/.venv"
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

ENTRYPOINT ["/home/compass/entrypoint.sh"]
