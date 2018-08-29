#!/usr/bin/env bash

# pull in arguments 
bulk_ips=$1
chart_name=$2
scope_of_time=$3
target_network=$4
system_ips=$(echo $bulk_ips | tr ',' ' ')

build_url(){

	# build each section
	url="http://$ip_address:19999"
	api="api/v1/data?chart=$chart_name"
	scope="after=-$scope_of_time"

	# paste it all together
	full_url="$url/$api&$scope"
}

debug(){

	# WTF is going on!
	printf '\n----------------------------------\n'
	printf " ip_address :      - $ip_address\n"
	printf " chart_name :      - $chart_name\n"
	printf " scope_of_time :   - $scope_of_time\n"
	printf " url :             - $url\n"
	printf " api :             - $api\n"
	printf " scope :           - $scope\n"
	printf " target_network :  - $target_network\n"
	printf " scope :           - $scope\n"
	printf " full_url :        - $full_url\n"
	printf " system_ips :      - $system_ips\n"
}

find_valid_ip(){

	# scan ips and set the target address
	for ip in $system_ips; do scan_ips $ip; done
}

scan_ips(){

	current_ip=$1
	pass_check=$(echo $current_ip | grep $target_network | wc -l)

	if [[ $pass_check -gt 0 ]]; then
		#statements
		export ip_address=$current_ip
	fi
}

query_api(){

	# go get the data
	curl -s $full_url
}

main(){

	# get it going!
	find_valid_ip
	build_url
	query_api
	debug
}

main

##system.ips## 'system.load' '5' '192.168.0'
