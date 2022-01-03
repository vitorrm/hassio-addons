#!/usr/bin/with-contenv bashio
# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    bashio::log.trace "${FUNCNAME[0]}"

    local email_domain=$(bashio::config 'email_domain')
    local authenticated_emails=$(bashio::config 'authenticated_emails')
    local redirect_url=$(bashio::config 'redirect_url')
    local cookie_secure=$(bashio::config 'cookie_secure')
    local cookie_secret=$(bashio::config 'cookie_secret')
    local cookie_refresh=$(bashio::config 'cookie_refresh')
    local provider=$(bashio::config 'provider')
    local client_id=$(bashio::config 'client_id')
    local client_secret=$(bashio::config 'client_secret')
    local extra_oauth2_params=$(bashio::config 'extra_oauth2_params')

    bashio::log.info "Starting OAuth2 Proxy"

    local oauth2_params=(
        --upstream=http://127.0.0.1:8080/ \
        --cookie-secret=${cookie_secret}\
        --cookie-secure=${cookie_secure} \
        --cookie-refresh=${cookie_refresh} \
        --provider=${provider} \
        --reverse-proxy=true \
        --set-authorization-header=true \
        --client-id=${client_id} \
        --client-secret=${client_secret} \
        --http-address=0.0.0.0:4180
    )

    # If redirect_url is NOT empty, add redirect-url param
    [[ ! -z "$redirect_url" ]] && oauth2_params+=(--redirect-url=${redirect_url})

    # If email_domain is NOT empty, add email-domain param
    if [[ ! -z "$email_domain" ]] 
    then
        bashio::log.info "Configuring email-domain with: ${email_domain}"
        oauth2_params+=(--email-domain=${email_domain})
    else
        bashio::log.info "Configuring authenticated-emails-file with: ${authenticated_emails}"
        readarray -t arr2 < <(printf '%s\n' "${authenticated_emails}")
        printf '%s\n' "${arr2[@]}" > /data/authenticated_emails.txt
        oauth2_params+=(--authenticated-emails-file=/data/authenticated_emails.txt)
    fi

    #Adding extra oauth2 parameters
    if [[ ${extra_oauth2_params[@]} ]]; then
        local param_name=""
        local param_value=""
        for extra_param in ${extra_oauth2_params[@]}; do
            param_name=$(jq '.name' <<< "$extra_param")
            param_value=$(jq '.value' <<< "$extra_param")
            if [[ ! -z "${param_name}" &&  ! -z "${param_value}" ]]; then
                oauth2_params+=(--${param_name}=${param_value})
            fi
        done
    fi

    /usr/bin/oauth2-proxy "${oauth2_params[@]}"
}

main "$@"