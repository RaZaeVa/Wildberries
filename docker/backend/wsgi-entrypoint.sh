#!/bin/sh

until cd /app/backend
do
    echo "Waiting for server volume..."
done

until python manage.py migrate
do
    echo "Waiting for db be ready..."
    sleep 2
done

python manage.py collectstatic --noinput

gunicorn wildberries.wsgi --bind 0.0.0.0:8000 --workers 4 --threads 4