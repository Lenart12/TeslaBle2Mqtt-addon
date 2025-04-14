# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

WORKDIR /build

# Install golang, git and nginx, remove default nginx site
RUN apk add --no-cache go git nginx && \
    mkdir -p /run/nginx && \
    rm -f /etc/nginx/http.d/default.conf

# Build TeslaBleHttpProxy [BlueZ] from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy-BlueZ \
    && cd /build/TeslaBleHttpProxy-BlueZ \
    && git checkout f14024081d75fbccdda858edb1eae64596d0dafb \
    && go build -o /usr/local/bin/TeslaBleHttpProxy-BlueZ

# Build TeslaBleHttpProxy from source
RUN git clone https://github.com/Lenart12/TeslaBleHttpProxy.git /build/TeslaBleHttpProxy \
    && cd /build/TeslaBleHttpProxy \
    && git checkout 980553e83cc07f6e204999ac0610e181c3fe3ce6 \
    && go build -o /usr/local/bin/TeslaBleHttpProxy
    
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

# Clean up
RUN rm -rf /build
    
CMD [ "/run.sh" ]