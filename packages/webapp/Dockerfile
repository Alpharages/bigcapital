# Stage 1: Build stage
FROM node:18.16.0-alpine as build

# Set working directory
WORKDIR /app

# Install required packages in a single layer to reduce image size
RUN apk add --no-cache python3 build-base

# Copy package.json and pnpm-lock.yaml first to leverage Docker layer caching
COPY package.json pnpm-lock.yaml* ./

# Install dependencies efficiently
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy the rest of the application files
COPY . .

# Build the webapp
RUN pnpm run build

# Stage 2: Production stage
FROM nginx:alpine

# Copy Nginx configuration
COPY ./nginx/sites/default.conf /etc/nginx/conf.d/default.conf

# Copy built assets from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]