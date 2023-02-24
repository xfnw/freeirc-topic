#!/usr/bin/env zsh

DOMAINS=${1:-domains}

parsedate(){

	dat="$1"
	if [ "$(uname)" = "OpenBSD" ]
	then
		date -j -f "%b %d %T %Y %z" "$dat" "+%s"
	elif [ -x /bin/busybox ]
	then
		busybox date -D "%b %d %T %Y %n" -d "$dat" "+%s"
	else
		date -d "$dat" '+%s'
	fi

}

getcerts(){

	for domain port in $(<$DOMAINS)
	do
		{
			expdate="$(catgirl -h $domain -p $port -o | openssl x509 -noout -enddate | cut -d= -f2)"
			now="$(date '+%s')"
			[ -z "$expdate" ] && echo "$domain:$port,,$now" ||
				echo "$domain:$port,$(parsedate "$expdate"),$now"
			echo "got $domain:$port" 1>&2
		} &
		sleep 0.1
	done

}


getcerts

