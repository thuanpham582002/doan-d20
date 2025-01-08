## build ##
FROM node:18-alpine as build

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine

# Install ca-certificates
RUN apk add --no-cache ca-certificates

# Create directory for custom certificates
RUN mkdir -p /usr/local/share/ca-certificates

# Copy your custom CA certificate
COPY ./rootCA.crt /usr/local/share/ca-certificates/

# Update CA certificates
RUN update-ca-certificates

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
