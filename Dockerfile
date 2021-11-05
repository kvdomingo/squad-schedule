FROM node:16-alpine as build

COPY ./web/app /web/app

WORKDIR /web/app

RUN npm install

RUN npm run build

FROM python:3.9.7-alpine as prod

RUN apk add --no-cache --update postgresql-dev gcc musl-dev

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /backend

COPY ./api/ ./api/
COPY ./squad_api/ ./squad_api/
COPY ./*.py ./
COPY --from=build /web/app/build ./web/app/

ARG DATABASE_URL
ENV DATABASE_URL $DATABASE_URL

RUN python manage.py collectstatic --noinput -c

EXPOSE $HTTP_PORT

ENTRYPOINT gunicorn squad_api.wsgi -b 0.0.0.0:$HTTP_PORT --capture-output --log-file -