#!/bin/bash

OWNER="r-bar"
REPO="helm-charts"
CI_ENDPOINT="https://ci.barth.tech"
TEAM="main"
PIPELINE="helm-charts"
WEBHOOK_TOKEN="push"
RESOURCE="repository"

WEBHOOK_URL="$CI_ENDPOINT/api/v1/teams/$TEAM/pipelines/$PIPELINE/resources/$RESOURCE/check/webhook?webhook_token=$WEBHOOK_TOKEN"

if [ -z "$PAT" ]; then
  echo Github personal access token required. Please set 'PAT=<token>' and try again.
  exit 1
fi

curl -s -u $OWNER:$PAT https://api.github.com/repos/r-bar/helm-charts/hooks | grep "$CI_ENDPOINT" \
  && echo Webhook already registered. Not registering new hook. \
  && exit 0

curl -s -X POST -u $OWNER:$PAT -d @- \
  -H "Content-Type: application/json" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/$OWNER/$REPO/hooks <<EOF
{
  "config": {
    "url": "$WEBHOOK_URL",
    "content_type": "application/json"
  }
}
EOF
