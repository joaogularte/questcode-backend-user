FROM node:14.15.4

WORKDIR /app/src

COPY package*.json ./

RUN npm install

COPY .  ./

EXPOSE 3020

CMD ["npm", "start"]
