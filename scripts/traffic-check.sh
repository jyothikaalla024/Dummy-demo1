
#!/bin/sh
URL="${URL:-http://dummy-svc/version}"
echo "timestamp,status,version,pod"
while true; do
  TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  BODY=$(curl -s --max-time 2 -w '\n%{http_code}' "$URL")
  RC=$?
  if [ "$RC" -ne 0 ]; then
    echo "$TS,ERR_curl_$RC,-,-"
  else
    CODE=$(echo "$BODY" | tail -n1)
    JSON=$(echo "$BODY" | head -n1)
    VER=$(echo "$JSON" | sed -n 's/.*"version": "\([^"]*\)".*/\1/p')
    POD=$(echo "$JSON" | sed -n 's/.*"pod": "\([^"]*\)".*/\1/p')
    echo "$TS,$CODE,${VER:--},${POD:--}"
  fi
  sleep 1
done
