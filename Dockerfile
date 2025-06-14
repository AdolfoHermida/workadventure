# Usa Node para build y nginx para servir
FROM node:18 AS build

WORKDIR /app
COPY . .

# Instala solo el frontend y lo builda
RUN cd front && npm install && npm run build

# Stage final con nginx
FROM nginx:alpine

# Copia el frontend construido
COPY --from=build /app/front/dist /usr/share/nginx/html

# Configura Nginx
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
