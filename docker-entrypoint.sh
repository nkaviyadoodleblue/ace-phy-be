#!/bin/sh

BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Detected BRANCH: $BRANCH"

if [ "$BRANCH" = "stage" ]; then
  echo "Starting in development mode..."
  SHORT_BRANCH='stage'
  npm run start:stage
elif [ "$BRANCH" = "preprod" ]; then
  echo "Starting in STAGE mode..."
  SHORT_BRANCH='preprod'
  npm run start:preprod
elif [ "$BRANCH" = "production" ]; then
  echo "Starting in production mode..."
  SHORT_BRANCH='production'
  npm run start
else
  echo "Unknown branch. Starting default mode..."
  npm run start
fi