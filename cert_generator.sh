#!/bin/bash

HOSTNAME=$1
PASSPHRASE=$2
OPTIONS="-subj /CN=${HOSTNAME}"

if [ -z "$HOSTNAME" ]
then
    echo "Usage: $(basename $0) <domain:required> <passphrase:optional>"
    exit 11
fi

if [ -z "$PASSPHRASE" ]
then
    echo "You haven't specified a passphrase so the private key will not be encrypted"
    OPTIONS+=" -nodes"
else
    echo "You've specified a passphrase so the private key will be encrypted"
    OPTIONS+="-passout pass:${PASSPHRASE}"
fi

openssl req -x509 -newkey rsa:4096 -keyout $(dirname $0)/${HOSTNAME}.key -out $(dirname $0)/${HOSTNAME}.crt -days 365 ${OPTIONS}

if [ $? == 0 ]
then
    echo "Certificate and key were successfully generated. They are in $(dirname $0) directory "
else
    echo "Something wrong, please try again"
fi
