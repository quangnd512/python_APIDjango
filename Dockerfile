FROM python:3.9-alpine3.13
LABEL maintainer='quangnd512.com'

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
#flake8
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
#flake8
COPY ./app /app
WORKDIR /app
EXPOSE 8000

#flake8
ARG DEV=false
#flake8
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    #flake8
    if [ $DEV = "true"]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    #flake8
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user