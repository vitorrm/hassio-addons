ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:17.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

ENV OAUTH2_PROXY_VERSION=7.8.1
ENV ARCHIVE=oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-amd64

# Setup base
RUN apk add --no-cache \
    coreutils=9.5-r2

# Download OAuth Proxy
RUN apk add --no-cache ca-certificates \
    && apk add --no-cache --virtual .build-deps curl \
    && curl -sL -o oauth2-proxy.tar.gz \
    "https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v$OAUTH2_PROXY_VERSION/$ARCHIVE.tar.gz" \
    && tar xzvf oauth2-proxy.tar.gz \
    && cp $ARCHIVE/oauth2-proxy /usr/bin \
    && chmod +x /usr/bin/oauth2-proxy \
    && apk del .build-deps \
    && rm -rf $ARCHIVE oauth2-proxy.tar.gz

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Vitor R Munhoz <vitor.rm@gmail.com>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Vitor R Munhoz <vitor.rm@gmail.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
