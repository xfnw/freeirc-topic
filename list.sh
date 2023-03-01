#!/usr/bin/env zsh

DOMAINS=${1:-domains}

getcerts(){

	for domain port in $(<$DOMAINS)
	do
		{
			echo "$(catgirl -h $domain -p $port -o | expdays || echo DOWN)\t$domain:$port"
			echo "got $domain:$port" 1>&2
		} &
		sleep 0.1
	done

}


sortedcerts(){

	getcerts | sort -rh

}

sortedcerts

