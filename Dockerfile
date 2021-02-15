FROM node:15.7.0-alpine3.10 AS builder

ARG HOME="/app"
ARG PUID=2000
ARG PGUID=2000

RUN addgroup --gid ${PGUID} questcode-backend-user && \
  adduser -D -u ${PUID} -G questcode-backend-user -s /bin/bash -h ${HOME} questcode-backend-user

USER questcode-backend-user:questcode-backend-user

RUN mkdir -p /app/src
WORKDIR ${HOME}/src
COPY --chown=questcode-backend-user:questcode-backend-user package*.json /app/src/
RUN npm install
COPY --chown=questcode-backend-user:questcode-backend-user .  /app/src/

FROM node:15.7.0-alpine3.10 as server

ARG HOME="/app"
ARG PUID=2000
ARG PGUID=2000

RUN addgroup --gid ${PGUID} questcode-backend-user && \
  adduser -D -u ${PUID} -G questcode-backend-user -s /bin/bash -h ${HOME} questcode-backend-user

USER questcode-backend-user:questcode-backend-user

WORKDIR /app
COPY --chown=questcode-backend-user:questcode-backend-user --from=builder /app/src /app
EXPOSE 3020
CMD ["npm", "start"]
