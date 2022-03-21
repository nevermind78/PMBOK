FROM python:3.6-slim
USER ${NB_USER}

RUN ./postBuild
