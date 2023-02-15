FROM nginx:alpine
COPY ./index.html /usr/share/nginx/html/
COPY ./index_files/metrics /usr/share/nginx/html/metrics
COPY ./analytics.php /usr/share/nginx/html/
COPY ./index_files/style.css /usr/share/nginx/html/index_files/
COPY ./index_files/doc_cookies.js /usr/share/nginx/html/index_files/
COPY ./index_files/tracking.js /usr/share/nginx/html/index_files/
EXPOSE 80