#!/bin/bash

default_interface=$(ip -o link show | awk -F': ' '{print $2}' | grep '^enx' | head -n 1)

if [ -z "$default_interface" ]; then
  default_interface=$(ip route | awk '/^default/ {print $5; exit}')
fi

echo $default_interface