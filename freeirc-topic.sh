#!/usr/bin/env zsh

datediff(){

	dat="$1"
	if [ "$(uname)" = "OpenBSD" ]
	then
		echo $(( ($(date -j -f "%F" "$dat" "+%s") - $(date '+%s')) / 86400 ))
	elif [ -x /bin/busybox ]
	then # -1 to correct for it rounding up
		echo $(( ($(busybox date -D "%Y-%m-%d" -d "$dat" "+%s") - $(busybox date '+%s')) / 86400 - 1 ))
	else
		echo $(( ($(date -d "$dat" '+%s') - $(date '+%s')) / 86400 ))
	fi

}

getcerts(){

	for domain port in $(<domains)
	do
		echo "getting $domain:$port" 1>&2
		echo "$(catgirl -h $domain -p $port -o | expdays || echo DOWN)\t$domain" &
		sleep 0.1
	done

}

getdates(){

	while IFS="	" read date name
	do
		echo "$(datediff $date)\t$name"
	done <dates

}

sortedcerts(){

	{getcerts; getdates} | sort -h | head -n4 |
	while IFS="	" read days domain
	do
		echo "$domain in $days days,"
	done |
		tr "\n" " " |
		sed 's/in DOWN days,/IS DOWN!!!/g; s/, $//'

}


./prefix "$(sortedcerts)"

