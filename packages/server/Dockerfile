# Use multi-stage build to reduce final image size
FROM node:18.16.0-alpine As build

# Define build arguments
ARG MAIL_HOST= \
  MAIL_USERNAME= \
  MAIL_PASSWORD= \
  MAIL_PORT= \
  MAIL_SECURE= \
  MAIL_FROM_NAME= \
  MAIL_FROM_ADDRESS= \
  # Database
  RUN_MIGRATIONS= \
  DB_HOST= \
  DB_USER= \
  DB_PASSWORD= \
  DB_CHARSET= \
  # System database.
  SYSTEM_DB_NAME= \
  SYSTEM_DB_PASSWORD= \
  SYSTEM_DB_USER= \
  SYSTEM_DB_HOST= \
  SYSTEM_DB_CHARSET= \
  # Tenant databases.
  TENANT_DB_USER= \
  TENANT_DB_PASSWORD= \
  TENANT_DB_HOST= \
  TENANT_DB_NAME_PERFIX= \
  TENANT_DB_CHARSET= \
  # MongoDB
  MONGODB_DATABASE_URL= \
  # Authentication
  JWT_SECRET= \
  # Application
  BASE_URL= \
  # Agendash
  AGENDASH_AUTH_USER=agendash \
  AGENDASH_AUTH_PASSWORD=123123 \
  # Sign-up restriction
  SIGNUP_DISABLED= \
  SIGNUP_ALLOWED_DOMAINS= \
  SIGNUP_ALLOWED_EMAILS= \
  NEW_RELIC_NO_CONFIG_FILE=

# Set environment variables
ENV MAIL_HOST=$MAIL_HOST \
  MAIL_USERNAME=$MAIL_USERNAME \
  MAIL_PASSWORD=$MAIL_PASSWORD \
  MAIL_PORT=$MAIL_PORT \
  MAIL_SECURE=$MAIL_SECURE \
  MAIL_FROM_NAME=$MAIL_FROM_NAME \
  MAIL_FROM_ADDRESS=$MAIL_FROM_ADDRESS \
  # Database
  RUN_MIGRATIONS=$RUN_MIGRATIONS \
  DB_HOST=$DB_HOST \
  DB_USER=$DB_USER \
  DB_PASSWORD=$DB_PASSWORD \
  DB_CHARSET=$DB_CHARSET \
  # System database.
  SYSTEM_DB_HOST=$SYSTEM_DB_HOST \
  SYSTEM_DB_USER=$SYSTEM_DB_USER \
  SYSTEM_DB_PASSWORD=$SYSTEM_DB_PASSWORD \
  SYSTEM_DB_NAME=$SYSTEM_DB_NAME \
  SYSTEM_DB_CHARSET=$SYSTEM_DB_CHARSET \
  # Tenant databases.
  TENANT_DB_NAME_PERFIX=$TENANT_DB_NAME_PERFIX \
  TENANT_DB_HOST=$TENANT_DB_HOST \
  TENANT_DB_PASSWORD=$TENANT_DB_PASSWORD \
  TENANT_DB_USER=$TENANT_DB_USER \
  TENANT_DB_CHARSET=$TENANT_DB_CHARSET \
  # Authentication
  JWT_SECRET=$JWT_SECRET \
  # Agendash
  AGENDASH_AUTH_USER=$AGENDASH_AUTH_USER \
  AGENDASH_AUTH_PASSWORD=$AGENDASH_AUTH_PASSWORD \
  # MongoDB
  MONGODB_DATABASE_URL=$MONGODB_DATABASE_URL \
  # Application
  BASE_URL=$BASE_URL \
  # Sign-up restriction
  SIGNUP_DISABLED=$SIGNUP_DISABLED \
  SIGNUP_ALLOWED_DOMAINS=$SIGNUP_ALLOWED_DOMAINS \
  SIGNUP_ALLOWED_EMAILS=$SIGNUP_ALLOWED_EMAILS \
  NEW_RELIC_NO_CONFIG_FILE=$NEW_RELIC_NO_CONFIG_FILE

# Create app directory and set permissions
WORKDIR /app
RUN chown node:node /app

# Install pnpm and required dependencies
RUN npm install -g pnpm

# Copy entire monorepo dependencies context required for the build
COPY . .

# remove unnecessary package
RUN rm -rf /app/packages/webapp

# Install production dependencies only
RUN pnpm install --frozen-lockfile

# Build the server
RUN pnpm run build:server --skip-nx-cache

# Use a lightweight Node.js runtime for production
FROM node:18.16.0-alpine AS production

# Set working directory
WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build /app .

# Install pnpm again in production
RUN npm install -g pnpm

# Set environment variables
ENV NODE_ENV=production

# Expose the necessary port (adjust as needed)
EXPOSE 3000

RUN chmod +x /app/bin/entrypoint.sh

# Command to start the server
ENTRYPOINT ["/app/bin/entrypoint.sh"]