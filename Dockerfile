FROM nginx:alpine

# Copy static files
COPY index.html /usr/share/nginx/html/index.html
COPY logo_qsd.png /usr/share/nginx/html/logo_qsd.png

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget -qO- http://localhost/index.html || exit 1

CMD ["nginx", "-g", "daemon off;"]
