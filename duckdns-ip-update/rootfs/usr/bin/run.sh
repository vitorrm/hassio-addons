#!/usr/bin/with-contenv bashio
# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------



function ts {
  echo [`date '+%b %d %X'`]
}

main() {
    bashio::log.trace "${FUNCNAME[0]}"

    local your_duckdns_domain=$(bashio::config 'your_duckdns_domain')
    local duckdns_token=$(bashio::config 'duckdns_token')
    local use_ipv6=$(bashio::config 'use_ipv6')
    local check_interval=$(bashio::config 'check_interval')
    local endpoint=https://www.duckdns.org/update

    #https://www.duckdns.org/update?domains={YOURVALUE}&token={YOURVALUE}[&ip={YOURVALUE}][&ipv6={YOURVALUE}][&verbose=true][&clear=true]
    bashio::log.info "Starting DuckDNS Ip Update"

   if [ "$use_ipv6" = "yes" ]; then
        ip6=`ifconfig | grep inet6 | grep -i global | awk -F " " '{print $3}' | awk -F "/" '{print $1}'`
        ip4=
        echo "IP address is ${ip6}"
    else
        echo "Will detect ipv4 automatically"
        ip6=
        ip4=
    fi

    while true
    do
        RESPONSE=$(curl -S -s "${endpoint}?domains=$your_duckdns_domain&token=$duckdns_token&ip=${ip4}&ipv6=${ip6}" 2>&1)

        if [ "$RESPONSE" = "OK" ]
        then
            bashio::log.trace "$(ts) DuckDNS successfully called. Result was \"$RESPONSE\"."
        elif [[ "$RESPONSE" == "KO" ]]
        then
            bashio::log.error "$(ts) DuckDNS reported an error. Check your settings. Result was \"$RESPONSE\"."
            exit 2
        else
            # For example: "curl: (6) Could not resolve host: www.duckdns.org". Also sometimes the response is ""
            bashio::log.error "$(ts) Something went wrong. Result was \"$RESPONSE\". Trying again later."
        fi

        sleep $check_interval
    done
}

main "$@"
