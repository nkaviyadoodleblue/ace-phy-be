FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM node:20-alpine
WORKDIR /app
RUN apk add --no-cache git
COPY --from=builder /app /app
COPY docker-entrypoint.sh /app/
RUN dos2unix /app/docker-entrypoint.sh && chmod +x /app/docker-entrypoint.sh
EXPOSE 2075
ENTRYPOINT ["/app/docker-entrypoint.sh"]
