#!/bin/bash

chown -R $USER ./config/
chown -R $USER ./workspace/

docker compose up -d --build