#!/bin/sh
set -eu
echo "poll '$HOST' password '$PASSWORD'" | fetchmail \
  --username "$USERNAME" \
  --protocol imap \
  --verbose \
  --ssl \
  --keep \
  --norewrite \
  --folder "$FOLDER" \
  --mda "./save.py" \
  -f -
