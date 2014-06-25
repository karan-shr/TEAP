#!/bin/bash

#FIXME TODO: this is really crappy, should make-it better !

current=$(pwd)
toexit=0

for folder in $(find ./ -type d); do
	cd $folder
	testResults=$(octave --quiet --eval "runtests('.')")

	if echo $testResults | grep -q failed
	then
		echo TEST FAIL IN $folder:
		echo "$testResults"
		toexit=1
	fi
	cd "$current"
done

exit $toexit
