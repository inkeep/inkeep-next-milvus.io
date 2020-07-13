# => Build container
FROM shanghaikid/milvus.io.builder as builder
ARG IS_PREVIEW 
ENV IS_PREVIEW $IS_PREVIEW
WORKDIR /site
COPY . .

RUN yarn build

# => Run container
FROM nginx:1.17-alpine

# Nginx config
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx

# Static build
COPY --from=builder /site/public /usr/share/nginx/html/

# Default port exposure
EXPOSE 80
