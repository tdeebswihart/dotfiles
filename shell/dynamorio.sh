function driousebuild {
    export DYNAMORIO_HOME=$PWD;
    echo "DYNAMORIO_HOME=$DYNAMORIO_HOME";
}
function runrio {
    arch=${1:-64};
    shift;
    if test -e $DYNAMORIO_HOME/bin${arch}/drrun ; then
        $DYNAMORIO_HOME/bin${arch}/drrun -${arch} $**;
    elif test -e $DYNAMORIO_HOME/bin/runstats ; then
        1. from within a build dir: no lib32/debug, etc.
        1. no -debug
        arg1=${1/-debug/};
        shift;
        $DYNAMORIO_HOME/bin/runstats \
            -env LD_LIBRARY_PATH "${DYNAMORIO_HOME}/lib:${LD_LIBRARY_PATH}" \
            -env LD_PRELOAD "libdrpreload.so libdynamorio.so" $arg1 $**;
    else
        echo Error: invalid home $DYNAMORIO_HOME
    fi
}
alias rio='runrio 32'
alias rio64='runrio 64'
alias drio='runrio 32 -debug'
alias drio64='runrio 64 -debug'
