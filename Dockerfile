FROM node:10-alpine as build-deps
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . ./

# Stage 2 - the production environment
FROM nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
