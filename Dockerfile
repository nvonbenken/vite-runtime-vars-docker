# Creation of intermediate docker image for build
FROM node:lts-bullseye-slim AS build-stage
WORKDIR /app

COPY ./ .

RUN npm ci
RUN npm run build

# Build import-meta-env binary for alpine linux
RUN npx pkg ./node_modules/@import-meta-env/cli/bin/import-meta-env.js -t node18-alpine -o import-meta-env

#Creation of final container that will get pushed to ACR
FROM nginx:alpine as production-stage
Run mkdir /app

COPY --from=build-stage /app/dist /app/dist
COPY --from=build-stage /app/import-meta-env /app/import-meta-env

COPY .env.example.public /app/.env.example.public
COPY start.sh /app/start.sh
COPY /nginx/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["sh", "/app/start.sh"]