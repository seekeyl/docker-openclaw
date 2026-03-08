#!/bin/bash

echo "===== OpenClaw Auto approve ====="
echo

# check for pending requests
PENDING_COUNT=$(openclaw devices list --json 2>/dev/null | jq '.pending | length' 2>/dev/null)

# Validate PENDING_COUNT is a number (use grep instead of [[ for better compatibility)
if ! echo "$PENDING_COUNT" | grep -qE '^[0-9]+$'; then
    echo "[Error] Failed to get pending count: '$PENDING_COUNT'"
    exit 1
fi

if [ "$PENDING_COUNT" -eq 0 ]; then
    echo "[Notice] No pending requests"
    exit 0
fi

echo "found $PENDING_COUNT pending request"
echo

# Approve request
OUTPUT=$(openclaw devices approve --latest 2>&1)
EXIT_CODE=$?
echo "$OUTPUT"

# check for "Approved" keyword and command success
if [ $EXIT_CODE -eq 0 ] && echo "$OUTPUT" | grep -q "Approved"; then
    echo
    echo "===== Success ====="
else
    echo
    echo "===== Failure ====="
fi