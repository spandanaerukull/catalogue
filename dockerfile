
FROM node:20-alpine3.20 AS builder
WORKDIR /opt/server
COPY package*.json .
RUN npm install --omit=dev
COPY . .

FROM node:20-alpine3.20
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
RUN apk add --no-cache musl openssl

ENV MONGO=true \
    MONGO_URL=mongodb://mongodb:27017/catalogue

WORKDIR /opt/server
COPY --from=builder /opt/server /opt/server
RUN chown -R roboshop:roboshop /opt/server

USER roboshop
CMD ["node","server.js"]