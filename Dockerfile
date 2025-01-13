FROM python:3.9-alpine3.13
LABEL maintainer="naseemamin98@outlook.com"

ENV PYTHONBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
#best practise to not use root user
    adduser \ 
    --disabled-password \
    --no-create-home \
    django-user

#define directories where executables can be run
ENV PATH="/py/bin:$PATH"

USER django-user

