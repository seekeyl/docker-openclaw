#!/bin/bash

while true; do
    sh /opt/scripts/approve.sh >> /tmp/openclaw-approve.log 2>&1
    sleep 10
done
