#!/bin/bash

echo "Creating system shortcuts..."

# Example shortcuts
if [ ! -e /netw ]; then
    sudo ln -s /etc/systemd/network /netw && echo "Linked /netw"
else
    echo "/netw already exists"
fi

if [ ! -e /services ]; then
    sudo ln -s /etc/systemd/system /services && echo "Linked /services"
else
    echo "/services already exists"
fi

