#!/usr/bin/env bash

script="$1"; shift
last_mod=0

while true; do
    curr_mod=$(stat -c %Y "$script")
    if ((curr_mod != last_mod)); then
        clear
        printf "\nOutput of %s\n\n" "$script"
        $script $@
        script_ec=$?
        if (( $script_ec != 0 )); then
            printf "\nWarning %s exited with non-zero exit code %d" $script_ec >&2
        fi
    fi
    sleep 1
done

