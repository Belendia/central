FROM node:carbon as intermediate

COPY ./ ./
RUN files/prebuild/write-version.sh
RUN files/prebuild/build-frontend.sh

FROM nginx

EXPOSE 80

ENTRYPOINT [ "/bin/bash", "/scripts/odk-setup.sh" ]

RUN apt-get update; apt-get install -y openssl netcat nginx-extras lua-zlib

RUN mkdir -p /scripts
COPY files/nginx/odk-setup.sh /scripts

COPY files/nginx/default /etc/nginx/sites-enabled/
COPY files/nginx/inflate_body.lua /usr/share/nginx
COPY files/nginx/odk.conf.template /usr/share/nginx

COPY --from=intermediate client/dist/ /usr/share/nginx/html
COPY --from=intermediate /tmp/version.txt /usr/share/nginx/html/

