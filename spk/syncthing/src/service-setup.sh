SERVICE_COMMAND="${SYNOPKG_PKGDEST}/bin/syncthing -home=${SYNOPKG_PKGVAR}"
SVC_BACKGROUND=y
SVC_WRITE_PID=y

GROUP="sc-syncthing"

service_prestart ()
{
    # Read additional startup options from /usr/local/syncthing/var/options.conf
    if [ -f ${SYNOPKG_PKGVAR}/options.conf ]; then
        # subshell is safer - won't override variables in current script
        (. ${SYNOPKG_PKGVAR}/options.conf)
        SERVICE_COMMAND="${SERVICE_COMMAND} ${SYNCTHING_OPTIONS}"
    fi

    # Required: set $HOME environment variable
    HOME=${SYNOPKG_PKGVAR}
    export HOME
}
