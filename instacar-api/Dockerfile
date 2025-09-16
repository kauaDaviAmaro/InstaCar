# ====== Build stage ======
FROM node:20-alpine AS build

WORKDIR /app

# Install build dependencies
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund

# Copy source and build
COPY tsconfig.json ./
COPY src ./src
RUN npm run build

# ====== Production runtime ======
FROM node:20-alpine AS runtime

ENV NODE_ENV=production
WORKDIR /app

# Install only production dependencies
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund

# Copy build artifacts
COPY --from=build /app/dist ./dist

# Copy source for Swagger (swagger-jsdoc parses annotations in src)
COPY src ./src

# Optional config
COPY nodemon.json ./nodemon.json

# Expose app port via env PORT (default 3000)
ENV PORT=3000
EXPOSE 3000

CMD ["node", "dist/server.js"]


