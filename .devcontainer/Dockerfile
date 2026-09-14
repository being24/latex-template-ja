FROM ghcr.io/being24/latex-docker

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends make \
    && rm -rf /var/lib/apt/lists/*
USER ubuntu
