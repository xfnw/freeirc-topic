#!/usr/bin/env zsh


getcerts(){

	for domain port in $(<domains)
	do
		echo "getting $domain:$port" 1>&2
		echo "$(catgirl -h $domain -p $port -o | expdays || echo DOWN)\t$domain"
	done

}


sortedcerts(){

	for days domain in $(getcerts | sort -h | head -n4)
	do
		echo "$domain in $days days,"
	done |
		tr "\n" " " |
		sed 's/in DOWN days,/IS DOWN!!!/g; s/, $//'

}


./prefix "$(sortedcerts)"

