# Use a lightweight web server
FROM nginx:alpine

# Copy your HTML file into the default nginx public directory
COPY index.html /usr/share/nginx/html/index.html