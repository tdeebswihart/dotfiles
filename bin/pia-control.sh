#!/bin/bash

RESOLV=/var/run/resolv.conf
AIRPORT="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
TRUSTED_NETWORK=chrowireless
PIA_PROCNAME="Private Internet Access"
PIA="/Applications/Private Internet Access.app/Contents/MacOS/Private Internet Access"
PIDFILE="/tmp/vpn-control.pia.pid"

## Logging helpers
log () {
    echo "[$(date)] $*"
}

log_info () {
    log "INFO - $*"
}

log_err () {
    log "ERRO - $*"
}

at_home () {
    local ssid=$($AIRPORT -I | egrep '\bSSID' | cut -d ':' -f2 | xargs | tr -d '\n')
    log_info "We're connected to $ssid"
    if [[ "$TRUSTED_NETWORK" = "$ssid" ]]; then
        return 0
    else
        return 1
    fi
}

vpn_running () {
    if pgrep "${PIA_PROCNAME}" &>/dev/null; then
        log_info "VPN is running!"
        return 0
    else
        log_info "VPN is NOT running!"
        return 1
    fi
}

if ! test -f "$PIA"; then
    log_err "Private Internet Access is not installed, so we've nothing to do!"
    exit 0
fi

if test -f "${RESOLV}"; then
    log_info "${RESOLV} exists, checking whether we're home"
    # If the resolv file doesn't exist then we're not connected to a network
    # So who cares what we do?
    if at_home; then
        # Kill PIA if its running AND only if this script started it, which will disconnect the VPN
        if test -f "${PIDFILE}"; then
            log_info "Killing current PIA process"
            PIA_PID=$(pgrep "${PIA_PROCNAME}")
            test "${PIA_PID}" && kill "${PIA_PID}"
            rm "${PIDFILE}"
        else
            log_info "PIA was enabled manually, so we'll leave it alone"
        fi
    else
        # Run it!
        # Don't start if its already running
        if ! vpn_running; then
            log_info "Starting PIA VPN client!"
            nohup "$PIA" > $HOME/Library/Logs/Local/private-internet-access.log 2>&1 &
            echo "$?" > "$PIDFILE"
        fi
    fi
fi

## BTT Helpers
if test -f ~/.secret/btt.sh; then
    source ~/.secret/btt.sh
    ICON_HOME="${BTT_ICONS}/Web/Web-Homepage.png"
    ICON_LOCKED="${BTT_ICONS}/Apple/XcodeSimulator/iPhone-Lock.png"
    ICON_UNLOCKED="${BTT_ICONS}/Console/GarageBand/panic.png"
    WIDGET_TEXT="VPN:%20Off"


    if vpn_running; then
        WIDGET_ICON="${ICON_LOCKED}"
        WIDGET_TEXT="VPN"
    elif at_home; then
        WIDGET_ICON="${ICON_HOME}"
        WIDGET_TEXT="Home"
    else
        WIDGET_ICON="${ICON_UNLOCKED}"
        WIDGET_TEXT="!VPN"
    fi
    update_btt_widget "${BTT_VPN_UUID}" "${WIDGET_TEXT}" "${WIDGET_ICON}"
fi
