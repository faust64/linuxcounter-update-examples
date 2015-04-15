#!/bin/bash

APIKEY="YOUR-APIKEY-HERE"

APIURL="http://api.linuxcounter.net/v1/"

###################################################################

function parse_json()
{
    echo $1 | \
    sed -e 's/[{}]/''/g' | \
    sed -e 's/", "/'\",\"'/g' | \
    sed -e 's/" ,"/'\",\"'/g' | \
    sed -e 's/" , "/'\",\"'/g' | \
    sed -e 's/","/'\"---SEPERATOR---\"'/g' | \
    awk -F=':' -v RS='---SEPERATOR---' "\$1~/\"$2\"/ {print}" | \
    sed -e "s/\"$2\"://" | \
    tr -d "\n\t" | \
    sed -e 's/\\"/"/g' | \
    sed -e 's/\\\\/\\/g' | \
    sed -e 's/^[ \t]*//g' | \
    sed -e 's/^"//'  -e 's/"$//'
}

curl=$( which curl )
if [[ "${curl}" = "" ]]; then
	echo "> cURL is needed for this example to work!  (sudo apt-get install curl)"
	exit 1
fi

echo "> Sending request for creating new machine..."
response=$( curl -s --request POST "${APIURL}machines" --header "x-lico-apikey: ${APIKEY}" )
response=$( echo "$response" | sed "s/:\([0-9]\)/:\"\1/g" | sed "s/\([0-9]\),\"/\1\",\"/g" | sed "s/\([0-9]\)\}/\1\"}/g"  )

machine_id=$( parse_json "${response}" machine_id )
machine_updatekey=$( parse_json "${response}" machine_updatekey )

echo "> Machine successfully created."
echo "> Got machine_id: ${machine_id}"
echo "> Got machine_updatekey: ${machine_updatekey}"

echo "> Updating machine with data:  hostname=some.example.com, distribution=Trisquel, distversion=7.0 LTS Belenos"
curl -s --request PATCH \
    "${APIURL}machines/${machine_id}" \
    --header "x-lico-machine-updatekey: ${machine_updatekey}" \
    --data 'hostname=some.example.com' \
    --data 'distribution=Trisquel' \
    --data 'distversion=7.0 LTS Belenos'
echo "> Machine updated."

echo "> Getting details of this new machine from the counter..."
curl --request GET \
    "${APIURL}machines/${machine_id}" \
    --header "x-lico-apikey: ${APIKEY}"




