#!/bin/bash

# 必要なパッケージのインストール
apt-get update
apt-get install -y tor

# Tor設定ファイルの作成
echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
echo "ControlPort 0.0.0.0:9051" >> /etc/tor/torrc

# Torをバックグラウンドで起動
tor &

# 環境変数を設定し、FastAPIアプリケーションの起動
uvicorn main:app --host 0.0.0.0 --port 8000
