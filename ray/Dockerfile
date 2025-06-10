ARG RAY_VERSION=2.46.0
FROM rayproject/ray:${RAY_VERSION}-py312
COPY requirements.txt compass-requirements.txt
RUN pip install --no-cache -r compass-requirements.txt;