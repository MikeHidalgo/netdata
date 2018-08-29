#!/usr/bin/env bash

# pull in arguments 
ip_address=$1
chart_name=$2
time=$3

# build each section
url="http://$ip_address:19999"
api="api/v1/data?chart=$chart_name"
scope="after=-$time"

# paste it all together
full_url="$url/$api&$scope"

main(){

	# go get the data
	curl -s $full_url
}

debug(){

	# WTF is going on!
	printf '\n------------------------------\n'
	printf " ip_address :    - $ip_address\n"
	printf " chart_name :    - $chart_name\n"
	printf " time :          - $time\n"
	printf " url :           - $url\n"
	printf " api :           - $api\n"
	printf " scope :         - $scope\n"
	printf " full_url :      - $full_url\n"
}

main
debug
