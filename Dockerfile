FROM nginx:latest

RUN apt-get update && apt-get install -y openssl curl

COPY ssl.conf ssl.conf
RUN openssl genrsa -out localhost.key 2048
RUN openssl req -new -sha256 \
        -subj "/C=AU/ST=NSW/L=Sydney/O=localhost/OU=localhost/CN=localhost" \
        -out localhost.csr \
        -key localhost.key \
        -config ssl.conf
RUN openssl req -text -noout -in localhost.csr
RUN openssl x509 -req \
        -sha256 \
        -days 3650 \
        -in localhost.csr \
        -signkey localhost.key \
        -out localhost.crt \
        -extensions req_ext \
        -extfile ssl.conf
RUN cp localhost.crt /etc/nginx/localhost.crt
RUN cp localhost.key /etc/nginx/localhost.key
COPY nginx.conf /etc/nginx/nginx.conf