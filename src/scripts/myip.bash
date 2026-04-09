#!/bin/bash

## Modern unified IP lookup tool
## Usage: myip [command] [ip]
##   myip            — show your external IP
##   myip local      — show local network IPs
##   myip info [ip]  — full info (own IP if no arg)
##   myip geo  [ip]  — geolocation (own IP if no arg)
##   myip org  [ip]  — organization (own IP if no arg)
##   myip all  [ip]  — all info formatted (own IP if no arg)
##   myip help       — show this help

_myip_validate() {
    [[ "$1" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] || return 1
}

_myip_fmt() {
    _bp_json_fmt
}

_myip_external() {
    curl -s ipinfo.io/ip; echo
}

_myip_lookup() {
    local target="$1"
    local endpoint="$2"

    if [ -z "$target" ]; then
        target=$(_myip_external)
    elif ! _myip_validate "$target"; then
        echo "error: '$target' is not a valid IP address" >&2
        return 1
    fi

    local url="ipinfo.io/${target}"
    [ -n "$endpoint" ] && url="${url}/${endpoint}"

    if [ "$endpoint" = "org" ]; then
        curl -s "$url"; echo
    else
        curl -s "$url" | _myip_fmt
    fi
}

myip() {
    local cmd="${1:-}"

    case "$cmd" in
        "")
            _myip_external
            ;;
        local)
            if [ -x /usr/sbin/ifconfig ] || [ -x /sbin/ifconfig ]; then
                ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
            elif [ -x /sbin/ip ] || [ -x /usr/sbin/ip ]; then
                /sbin/ip -4 addr show 2>/dev/null || /usr/sbin/ip -4 addr show | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
            else
                echo "error: neither 'ifconfig' nor 'ip' found" >&2
                return 1
            fi
            ;;
        info)
            _myip_lookup "$2"
            ;;
        geo)
            _myip_lookup "$2" "geo"
            ;;
        org)
            _myip_lookup "$2" "org"
            ;;
        all)
            local target="${2:-$(_myip_external)}"
            echo "=== IP: $target ==="
            echo ""
            echo "--- Info ---"
            _myip_lookup "$target"
            echo ""
            echo "--- Geo ---"
            _myip_lookup "$target" "geo"
            echo ""
            echo "--- Org ---"
            _myip_lookup "$target" "org"
            echo ""
            ;;
        help|-h|--help)
            echo "Usage: myip [command] [ip]"
            echo ""
            echo "Commands:"
            echo "  (none)       show your external IP"
            echo "  local        show local network IPs"
            echo "  info [ip]    full info (own IP if no arg)"
            echo "  geo  [ip]    geolocation (own IP if no arg)"
            echo "  org  [ip]    organization (own IP if no arg)"
            echo "  all  [ip]    all info formatted"
            echo "  help         show this help"
            ;;
        *)
            # treat bare IP as shorthand for 'myip info <ip>'
            if _myip_validate "$cmd"; then
                _myip_lookup "$cmd"
            else
                echo "error: unknown command '$cmd'. Run 'myip help' for usage." >&2
                return 1
            fi
            ;;
    esac
}
