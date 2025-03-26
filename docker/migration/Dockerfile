# Use prebuilt server image
FROM bigcapitalhq/server:latest AS build

# Set environment variables using ARG + ENV for Dockerfile-time substitution
ARG DB_HOST \
    DB_USER \
    DB_PASSWORD \
    DB_CHARSET \
    SYSTEM_DB_NAME \
    SYSTEM_DB_PASSWORD \
    SYSTEM_DB_USER \
    SYSTEM_DB_HOST \
    SYSTEM_DB_CHARSET

ENV DB_HOST=$DB_HOST \
    DB_USER=$DB_USER \
    DB_PASSWORD=$DB_PASSWORD \
    DB_CHARSET=$DB_CHARSET \
    SYSTEM_DB_HOST=$SYSTEM_DB_HOST \
    SYSTEM_DB_USER=$SYSTEM_DB_USER \
    SYSTEM_DB_PASSWORD=$SYSTEM_DB_PASSWORD \
    SYSTEM_DB_NAME=$SYSTEM_DB_NAME \
    SYSTEM_DB_CHARSET=$SYSTEM_DB_CHARSET

USER root

# Combine apk calls to reduce layers and use `--no-cache`
RUN apk update && apk upgrade && \
    apk add --no-cache bash git

# Set working directory to the server package
WORKDIR /app/packages/server

RUN git clone https://github.com/vishnubob/wait-for-it.git

# Run migration after DB is ready
CMD ./wait-for-it/wait-for-it.sh mysql:3306 -- \
    sh -c "node ./build/commands.js system:migrate:latest && node ./build/commands.js tenants:migrate:latest"