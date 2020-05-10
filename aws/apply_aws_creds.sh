#!/usr/bin/env bash

echo AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials.csv | sed '1d' | awk -F ',' '{print $3}')
echo AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials.csv | sed '1d' | awk -F ',' '{print $4}')