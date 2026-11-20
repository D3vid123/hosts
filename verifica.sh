#!/bin/bash

verifica_ip()
{
    host=$1
    ip=$2
    dns=$3

    rezultat=$(nslookup "$host" "$dns" 2>/dev/null |
        awk '$1=="Name:" {found=1}
             found && $1=="Address:" {print $2}')

    if echo "$rezultat" | grep -Fxq "$ip"; then
        echo "$host - asociere corecta"
    else
        echo "$host - asociere incorecta"
    fi
}

while read -r ip host rest
do
    [[ -z "$ip" || "$ip" == \#* ]] && continue

    verifica_ip "$host" "$ip" "8.8.8.8"

done < /etc/hosts
echo "Realizat de Mihnea"
