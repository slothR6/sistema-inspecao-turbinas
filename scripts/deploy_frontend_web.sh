#!/usr/bin/env bash
set -euo pipefail

PROJECT_ID="${PROJECT_ID:-seu-projeto}"
cd "$(dirname "$0")/../frontend_flutter"

flutter build web --release
firebase deploy --project "$PROJECT_ID" --only hosting
