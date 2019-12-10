#!/bin/sh
# set -x
echo "$0: starting"

# if the admin password is defined in the ENV variable, we append to the config
if [ -n "${ADMINPASSWD-}" ]; then
	echo "$0: ADMINPASSWD provided"
else
	echo "$0: ADMINPASSWD not provided"
fi

# We figure out what is the current db folder
if [ "${NXTNET:=test}" = "main" ]; then
	# main net
	TESTNET=false
	NXTNET=main
else
	# everything else defaults to test net
	TESTNET=true
	NXTNET=test
fi
echo "$0: running ${NXTNET} NXTNET"

if [ ! -f "/ardor/conf/version" ]; then
	echo -e "$0: Performing version $NRSVersion init..."

	# if a script was provided, we download it locally
	# then we run it before anything else starts
	if [ -n "${SCRIPT-}" ]; then
		filename=$(basename "$SCRIPT")
		echo "$0: running SCRIPT ${filename}"
		wget "$SCRIPT" -O "/nxt-boot/scripts/$filename"
		chmod u+x "/nxt-boot/scripts/$filename"
		/nxt-boot/scripts/$filename
	fi

	if [ -n "${PLUGINS-}" ]; then
		echo "$0: loading PLUGINS"
		/nxt-boot/scripts/install-plugins.sh "$PLUGINS"
	else
		echo "$0: PLUGINS not provided"
	fi

	# If we did all of that, we dump a file that will signal next time that we
	# should not run the init-script again
	echo ${NRSVersion} >/ardor/conf/version
fi

# $BLOCKCHAINDL must point to a zip that contains the nxt_db folder itself.
if [ -n "${BLOCKCHAINDL-}" -a ! -d "/ardor/db/nxt_${NXTNET}_db" ]; then
	echo "$0: downloading blockchain from $BLOCKCHAINDL"
	rm -f /ardor/db/nxt_db.zip
	wget --no-check-certificate "$BLOCKCHAINDL" -O /ardor/db/nxt_db.zip && unzip /ardor/db/nxt_db.zip && mv nxt_db /ardor/db/nxt_${NXTNET}_db
	rm -f /ardor/db/nxt_db.zip
	echo "$0: Blockchain download $BLOCKCHAINDL complete"
else
	echo "$0: No blockchain bootstrap. Either BLOCKCHAINDL not provided or directory already exists"
fi

echo "$0: Preparing config for ${NXTNET} net"
sed -e "s/ADMINPASSWD/${ADMINPASSWD}/g" \
	-e "s/TESTNET/${TESTNET}/g" \
	-e "s/NXTNET/${NXTNET}/g" \
	-e "s/MYPLATFORM/${MYPLATFORM:-Docker}/g" \
	-e "s/MYADDRESS/${MYADDRESS}/g" \
	-e 's/\r$//g' \
	</nxt-boot/conf/nxt-${NXTNET:-test}.properties >/ardor/conf/nxt.properties

echo "$0: init finished, starting blockchain"
# sleep 300 # allow to check everything before start
./run.sh
