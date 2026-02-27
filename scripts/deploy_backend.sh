#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-seu-projeto}"
REGION="${REGION:-us-central1}"
SERVICE="${SERVICE:-backend-inspecoes}"
IMAGE="gcr.io/${PROJECT_ID}/${SERVICE}:latest"

cd "$(dirname "$0")/../backend_python/backend"

gcloud builds submit --tag "$IMAGE" .
gcloud run deploy "$SERVICE" \
  --image "$IMAGE" \
  --region "$REGION" \
  --platform managed \
  --allow-unauthenticated=false
