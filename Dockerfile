FROM node:20.18.3-alpine3.21 AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=build /app/dist/ .

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]



