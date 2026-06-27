#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

PORT="${PORT:-1313}"
IP="$(hostname -I | awk '{print $1}')"

if [[ -z "${IP}" ]]; then
  echo "Could not detect a LAN IP address." >&2
  exit 1
fi

if ss -tln | grep -q ":${PORT} "; then
  echo "Port ${PORT} is already in use." >&2
  echo "Stop the existing Hugo server first (Ctrl+C in its terminal, or: pkill hugo)" >&2
  exit 1
fi

echo "Starting Hugo dev server"
echo "  Local:   http://localhost:${PORT}/"
echo "  Mobile:  http://${IP}:${PORT}/"
echo
echo "Press Ctrl+C to stop."

exec hugo server --bind 0.0.0.0 --port "${PORT}" --baseURL "http://${IP}:${PORT}/"
