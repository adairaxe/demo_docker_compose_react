FROM node:lts-alpine as build-stage
RUN mkdir app
WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build
FROM nginx:1.27.0-alpine as product-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]