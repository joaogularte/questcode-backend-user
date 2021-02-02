FROM node:14.15.4 AS builder
WORKDIR /app/src
COPY package*.json ./
RUN npm install
COPY .  ./

FROM node:14.15.4 as server
WORKDIR /app
COPY --from=builder /app/src /app
EXPOSE 3020
CMD ["npm", "start"]
