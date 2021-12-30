# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    bashio::log.trace "${FUNCNAME[0]}"

    local email_domain=$(bashio::config 'email_domain')
    local cookie_secure=$(bashio::config 'cookie_secure')
    local cookie_secret=$(bashio::config 'cookie_secret')
    local cookie_refresh=$(bashio::config 'cookie_refresh')
    local provider=$(bashio::config 'provider')
    local client_id=$(bashio::config 'client_id')
    local client_secret=$(bashio::config 'client_secret')

    bashio::log.info "Starting OAuth2 Proxy"

    ./usr/bin/oauth2-proxy \
    --email-domain=${email_domain} \
    --upstream=http://127.0.0.1:8080/ \
    --cookie-secret=${cookie_secret} \
    --cookie-secure=${cookie_secure} \
    --cookie-refresh=${cookie_refresh} \
    --provider=${provider} \
    --reverse-proxy=true \
    --client-id=${client_id} \
    --client-secret=${client_secret}
}

main "$@"