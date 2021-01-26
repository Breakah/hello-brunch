FROM node:lts-buster as nodebuild
WORKDIR /build/
COPY . /build/
RUN brunch
RUN brunch build
FROM nginx
COPY --from=nodebuild /build/public/ /usr/share/nginx/html/
