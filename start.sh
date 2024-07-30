#!/bin/bash

sudo apt-get update
sudo apt-get install -y tor

sudo sh -c 'echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc'
sudo sh -c 'echo "ControlPort 0.0.0.0:9051" >> /etc/tor/torrc'

sudo systemctl start tor

pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8000
