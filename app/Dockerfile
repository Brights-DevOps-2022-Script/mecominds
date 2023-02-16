FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html/
COPY ./index_files/style.css /usr/share/nginx/html/index_files/
COPY ./img/favicon.ico  /usr/share/nginx/html/
COPY ./static_metrics /usr/share/nginx/html/static_metrics/
EXPOSE 80