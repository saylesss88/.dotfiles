#!/bin/bash

# Check for staged updates or available upgrades
# rpm-ostree upgrade --check returns JSON with 'available-upgrades'
updates=$(rpm-ostree upgrade --check --json | jq '.["available-upgrades"] | length')

if [ "$updates" -gt 0 ]; then
    printf '{"text": "%s", "alt": "has-updates", "tooltip": "%s updates available"}\n' "$updates" "$updates"
else
    printf '{"text": "0", "alt": "updated", "tooltip": "System up to date"}\n'
fi
