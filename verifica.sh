#!/bin/bash

while read -r ip host rest
do
    [[ -z "$ip" || "$ip" == \#* ]] && continue

    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        valid=1

        for octet in ${ip//./ }
        do
            if (( octet > 255 )); then
                valid=0
            fi
        done

        if (( valid == 1 )); then
            echo "$host - IP valid: $ip"
        else
            echo "$host - IP invalid: $ip"
        fi
    else
        echo "$host - IP invalid: $ip"
    fi
done < /etc/hosts
