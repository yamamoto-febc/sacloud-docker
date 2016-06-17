#!/bin/bash

set -eo pipefail

if [ -z "$SAKURACLOUD_ACCESS_TOKEN" ]; then
  echo >&2 '$SAKURACLOUD_ACCESS_TOKEN is not set. Please set $SAKURACLOUD_ACCESS_TOKEN'
  exit 1
else
  sacloud config --accessToken=$SAKURACLOUD_ACCESS_TOKEN >> /dev/null 2>&1
fi

if [ -z "$SAKURACLOUD_ACCESS_TOKEN_SECRET" ]; then
  echo >&2 '$SAKURACLOUD_ACCESS_TOKEN_SECRET is not set. Please set $SAKURACLOUD_ACCESS_TOKEN_SECRET'
else
  sacloud config --accessTokenSecret=$SAKURACLOUD_ACCESS_TOKEN_SECRET >> /dev/null 2>&1
fi

if [ -z "$SACLOUD_REGION" ]; then
  SACLOUD_REGION="is1a"
fi

if [ "`expr "$SACLOUD_REGION" : '\(is1a\|is1b\|tk1a\|tk1v\)'`" ]; then
  sacloud config --apiRoot="https://secure.sakura.ad.jp/cloud/zone/$SACLOUD_REGION/api/cloud/1.1/" >> /dev/null 2>&1
else
  echo >&2 '$SACLOUD_REGION is invalid. set in [is1a/is1b/tk1a/tk1v]'
  exit 1
fi    

sacloud "$@"

