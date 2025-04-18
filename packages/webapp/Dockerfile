# Stage 1: Build stage
FROM node:18.16.0-alpine As build

# Set working directory
WORKDIR /app

# Install required packages in a single layer to reduce image size
RUN apk add --no-cache python3 build-base

# Copy entire monorepo dependencies context required for the build
COPY . .

# remove unnecessary package
RUN rm -rf /app/packages/server

# Install dependencies efficiently
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Build the webapp
RUN pnpm run build:webapp

# Stage 2: Production stage
FROM nginx:alpine

# Copy Nginx configuration
COPY /packages/webapp/nginx/sites/default.conf /etc/nginx/conf.d/default.conf

# Copy built assets from the build stage
COPY --from=build /app/packages/webapp/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]