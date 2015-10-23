#!/bin/bash

PDF_SHA=$(curl -u "$GITHUB_AUTH" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/$TRAVIS_REPO_SLUG/git/trees/gh-pages:output" | jq -r ".tree[0].sha")


curl -u "$GITHUB_AUTH" -H "Accept: application/vnd.github.v3+json" -X PUT -d @- "https://api.github.com/repos/$TRAVIS_REPO_SLUG/contents/output/erstiheft.pdf" <<CURL_DATA
{
  "message": "update pdf",
  "sha": "$PDF_SHA",
  "committer": {
    "name": "travis",
    "email": "travis@travis-ci.org"
  },
  "branch": "gh-pages",
  "content": "$(base64 erstiheft.pdf)"
}
CURL_DATA
