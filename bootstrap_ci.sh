#!/bin/bash
echo -e "[buildout]\nlogin = admin\npassword = admin" > secret.cfg
ln -fs local_test.cfg local.cfg
./bin/pip install -r requirements.txt
./bin/develop up -f || true
./bin/buildout -t 3 || ./bin/buildout -v
