#!/bin/bash -e

echo -ne "Running with "

python3 --version

echo Creating and populating virtualenv..

python3 -m venv venv
. venv/bin/activate

pip install --upgrade pip pip-tools wheel
make

cd src

echo Collecting static assets...
./manage.py collectstatic

echo Running initial migrations...
./manage.py migrate

cd ../
echo Apply formatting..
make fmt

echo Running flake8..
make lint

echo Running pytest...
make test

echo Done
