### Stage 1: Build Stage

FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

### Stage 2: Production Stage

FROM node:20-alpine AS production

# Set working directory
WORKDIR /app

# Copy necessary files from build stage
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
# Expose application port
EXPOSE 3000

# Start the application
CMD ["node", "src/index.js"]
