FROM node:23-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .

# GetEnv
ARG PUBLIC_API_URL
ENV PUBLIC_API_URL=$PUBLIC_API_URL
RUN npm run build

FROM nginx:alpine

 #copy the dist folder to nginx
COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]