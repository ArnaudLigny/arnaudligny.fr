#!/bin/bash -e

echo "Purge Cloudflare cache (zone: ${CLOUDFLARE_ZONE})"

curl -X DELETE "https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE}/purge_cache" \
    -H "X-Auth-Email: ${CLOUDFLARE_EMAIL}" \
    -H "X-Auth-Key: ${CLOUDFLARE_API}" \
    -H "Content-Type: application/json" \
    --data '{"purge_everything":true}'
