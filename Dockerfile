FROM node:lts as build
WORKDIR /app
COPY . /app
RUN npm install --silent
COPY . ./
RUN npm run build


# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
ENTRYPOINT ["nginx","-g","daemon off;"]
