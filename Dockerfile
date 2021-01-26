FROM node:lts-buster as nodebuild
WORKDIR /build/
COPY . /build/
RUN npm install -g brunch
RUN brunch build
#RUN yarn
#RUN yarn build
FROM nginx
COPY --from=nodebuild /build/public/ /usr/share/nginx/html/
