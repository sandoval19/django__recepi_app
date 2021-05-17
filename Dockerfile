# IMPORT FROM DOCKERHUB A STABLE PYTHON IMAGE
FROM python:3.6-alpine
# SET MAINTAINER
MAINTAINER Sandoval19
# SET ENVIRONMENT VARIABLES
# ALLOWS TO PYTHON TO DISPLAY ON CONSOLE
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .temp-build-deps \
        gcc libc-dev linux-headers postgresql-dev

RUN pip install -r /requirements.txt 

RUN apk del .temp-build-deps

RUN  mkdir /app
# SET WORKING DIRECTORY
WORKDIR /app
COPY ./app /app

# CREATE A USER TO RUN APPLICATION 
# THIS USER WILL BE ONLY ALLOWED TO EXECUTE
# THIS USER WONT HAVE A HOME DIRECTORY
# THIS IS FOR SECURITY PROPOUSES

RUN adduser -D deploy
USER deploy
