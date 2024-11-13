FROM registry.access.redhat.com/ubi9/nginx-124:1


# Add application sources
# COPY test-app/nginx.conf "${NGINX_CONF_PATH}"
# COPY nginx-example-app/logging.conf "${NGINX_DEFAULT_CONF_PATH}"
COPY nginx-example-app/logging.conf "${NGINX_CONFIGURATION_PATH}"
COPY  nginx-example-app/*.html \
      nginx-example-app/*.ico \
      nginx-example-app/*.css \
      nginx-example-app/*.png \
      .
# Update index.html
RUN sed -i "s/REPLACEME/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)/" index.html

# Update logging conf
RUN sed -i "s/REPLACEME/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)/" "${NGINX_CONFIGURATION_PATH}/logging.conf"

# Create /otq-challenge-flag.txt
RUN echo $(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) > /var/tmp/otq-challenge-flag.txt

# Run script uses standard ways to run the application
CMD nginx -g "daemon off;"