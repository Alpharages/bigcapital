#!/bin/sh
set -e

if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "🚀 Running migrations..."
  node /app/packages/server/build/commands.js system:migrate:latest
  node /app/packages/server/build/commands.js tenants:migrate:latest
  echo "✅ Migrations complete."
else
  echo "ℹ️ Skipping migrations (RUN_MIGRATIONS=$RUN_MIGRATIONS)"
fi

# Start the server
pnpm run serve:server