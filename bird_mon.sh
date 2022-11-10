#!/bin/bash

case $1 in
    get_peers)
            # Produce JSON list of BGP sessions..

            sudo birdc show proto | awk '
            BEGIN { sep = "" }
            $2 == "BGP" {
              if (sep == "") { printf "%s", "{\"data\":[" }
              printf "%s{\"peer_name\":\"%s\"}", sep, $1;
              if (sep == "") { sep = ", " }
            }
            END { if (sep != "") { print "]}" } }'
    ;;

    diff_config_birdc)
            #Scan bird conf files and get configured bgp session and show difference between birdc output
            CONFIG=$(grep -r "^protocol bgp" /etc 2>/dev/null | wc -l)
            BIRDC=$(sudo birdc show proto | grep -cw BGP)
            
            test "$CONFIG" = "$BIRDC" && echo '0' || echo '1'
    ;;

    link_status)
            # 1) Get BGP link info to zabbix.
            # 2) Read and update cache file.
            
            PEER="$2"
            
#            TTL_TIME="$(date +%s -d "120 seconds ago")"
            
#            CACHE_FILE="/var/run/zabbix/birdlink.cache"
#            test -s "${CACHE_FILE}" &&
#              CACHE_TIME="$(date +%s -r "${CACHE_FILE}")" || CACHE_TIME=0
            
#            test "${CACHE_TIME}" -le "${TTL_TIME}" &&
#              sudo birdc show proto > "${CACHE_FILE}.new" &&
#              mv "${CACHE_FILE}.new" "${CACHE_FILE}" &&
#              chown zabbix "${CACHE_FILE}"
# echo "None"           
#            awk '$1 == "'$PEER'" { print $6 }' "$CACHE_FILE"
            birdc show proto | awk '$1 == "'$PEER'" { print $6 }' 
    ;;

esac
