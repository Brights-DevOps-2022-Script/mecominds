FROM nginx:alpine
COPY ./app index.html /usr/share/nginx/html/
COPY ./app/style.css /usr/share/nginx/html/index_files/
EXPOSE 80