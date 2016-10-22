SHA=$1
CONTEXT=$2
STATE=$3
TARGET_URL=$4

curl -XPOST -H "Authorization: token ${GITHUB_TOKEN}" \
    https://api.github.com/repos/Neft-io/neft/statuses/${SHA} -d "{
      \"state\": \"${STATE}\",
      \"target_url\": \"${TARGET_URL}\",
      \"context\": \"${CONTEXT}\"
    }" \
    --silent \
    --show-error
