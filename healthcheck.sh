#!/bin/bash

check1=$( cat /fluentd/etc/cache/worker0/storage.json )
sleep 15
check2=$( cat /fluentd/etc/cache/worker0/storage.json )

if [ "$check1" = "$check2" ] ; then
  exit 1 ;
fi
