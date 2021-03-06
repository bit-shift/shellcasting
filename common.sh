osd() {
    echo -e "$8" | osd_cat -p $1 -A $2 -f -*-fixed-*-*-*-*-*-${3}-*-*-*-*-*-* -c $4 -O $5 -u $6 -d $7
}

notify() {
    [[ -t 0 ]] && echo -e "$@" || osd bottom right 200 white 2 black 5 "$@"
}

die() {
    notify "$@"
    exit 1
}

depend() {
    for cmd in $@; do
        which $cmd > /dev/null 2>&1 || die "FATAL ERROR: required command '${cmd}' is missing."
    done
}

fixpath() {
    if [[ "$1" =~ ^~ ]]
    then
        echo "${HOME}${1:1}"
    else
        echo "$1"
    fi
}

config() {
    CONFDIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
    [[ -d "$CONFDIR" ]] && CONFIG="${CONFIG:-${CONFDIR}/$(basename $0).cfg}" || CONFIG="${CONFIG:-${HOME}/.$(basename $0)rc}"
    CONFIG="$(fixpath $CONFIG)"
    [[ -r "$CONFIG" ]] && source $CONFIG
    RUNDIR="${RUNDIR:-${HOME}/.run}"
    RUNDIR="$(fixpath $RUNDIR)"
    [[ -d "$RUNDIR" ]] || RUNDIR=$PWD
    PIDPREFIX="${PIDPREFIX:-${RUNDIR}/.$(basename $0)}"
    LOGDIR="${LOGDIR:-${HOME}/log}"
    LOGDIR="$(fixpath $LOGDIR)"
    [[ -d "$LOGDIR" ]] || LOGDIR=$PWD
}
