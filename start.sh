#!/bin/bash

apt-get update
apt-get install -y tor

echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
echo "ControlPort 0.0.0.0:9051" >> /etc/tor/torrc

tor &

pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000
