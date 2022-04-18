#!/usr/bin/env zsh


./freeirc-topic.sh | 
	scirc              \
	-h irc.freeirc.org \
	-n freeirc-topic   \
	-j "#freeirc-team" \
	-w


