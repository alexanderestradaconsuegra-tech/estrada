FROM nginx:1.27-alpine

# Los archivos se copian del repositorio que EasyPanel clona en el build.
# Antes se descargaban con curl desde la rama main: la capa se cacheaba y
# el commit desplegado no era trazable.
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY security-headers.conf /etc/nginx/snippets/security-headers.conf
COPY index.html manifest.json sw.js icon-192.png icon-512.png /usr/share/nginx/html/

# Versiona el service worker con el commit para invalidar cachés viejas
ARG BUILD_VERSION=dev
RUN sed -i "s/__BUILD_VERSION__/${BUILD_VERSION}/" /usr/share/nginx/html/sw.js

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1/health || exit 1
CMD ["nginx", "-g", "daemon off;"]
