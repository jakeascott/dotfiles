#!/bin/sh

# From the arch wiki, relaunches DWM if the binary hanges, otherwise logs out.
csum=$(sha1sum $(which dwm))
new_csum=""
while true; do
    if [ "$csum" != "$new_csum" ]
    then
        csum=$new_csum
        dwm 2> ~/.dwm.log
    else
        exit 0
    fi
    new_csum=$(sha1sum $(which dwm))
    sleep 0.5
done
