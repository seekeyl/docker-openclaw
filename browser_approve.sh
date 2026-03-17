#!/bin/bash
# OpenClaw 设备审批自动脚本 (Linux版)

echo "===== OpenClaw 设备审批自动脚本 ====="
echo

docker exec -it docker-openclaw openclaw devices approve

sleep 3