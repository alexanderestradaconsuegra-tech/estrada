FROM nginx:alpine
RUN apk add --no-cache curl

# Download app files from GitHub
RUN curl -L "https://raw.githubusercontent.com/alexanderestradaconsuegra-tech/estrada/main/index.html" -o /usr/share/nginx/html/index.html
RUN curl -L "https://raw.githubusercontent.com/alexanderestradaconsuegra-tech/estrada/main/manifest.json" -o /usr/share/nginx/html/manifest.json
RUN curl -L "https://raw.githubusercontent.com/alexanderestradaconsuegra-tech/estrada/main/sw.js" -o /usr/share/nginx/html/sw.js
RUN curl -L "https://raw.githubusercontent.com/alexanderestradaconsuegra-tech/estrada/main/icon-192.png" -o /usr/share/nginx/html/icon-192.png
RUN curl -L "https://raw.githubusercontent.com/alexanderestradaconsuegra-tech/estrada/main/icon-512.png" -o /usr/share/nginx/html/icon-512.png

# Nginx config for PWA - proper headers
RUN echo 'server { \
  listen 80; \
  root /usr/share/nginx/html; \
  index index.html; \
  \
  # Service worker must be served from root \
  location /sw.js { \
    add_header Cache-Control "no-cache, no-store, must-revalidate"; \
    add_header Service-Worker-Allowed "/"; \
  } \
  \
  # Manifest \
  location /manifest.json { \
    add_header Cache-Control "no-cache"; \
    add_header Content-Type "application/manifest+json"; \
  } \
  \
  # HTML - no cache \
  location /index.html { \
    add_header Cache-Control "no-cache, no-store, must-revalidate"; \
  } \
  \
  # Static assets - cache 7 days \
  location ~* \.(png|jpg|jpeg|gif|ico|svg)$ { \
    add_header Cache-Control "public, max-age=604800"; \
  } \
  \
  # SPA fallback \
  location / { \
    try_files $uri $uri/ /index.html; \
  } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
