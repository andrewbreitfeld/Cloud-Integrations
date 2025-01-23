#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y wget
wget -O Dynatrace-ActiveGate-Linux-x86-Azure_USEAST_AGs-1.298.0.20240717-102919.sh "<envurlhere>/api/v1/deployment/installer/gateway/unix/latest?arch=x86" --header="Authorization: Api-Token dt0c01.B6BJYU2QLJA7DZ2MVPY67FK5.IOSZEWKWI4GJXP6N2GSMR2GQQSOFRFB7J67FV7XJWENFM3ZQ5DCNMSNZ3XOVQMQJ"
sudo chmod +x Dynatrace-ActiveGate-Linux-x86-Azure_USEAST_AGs-1.298.0.20240717-102919.sh
sudo ./Dynatrace-ActiveGate-Linux-x86-Azure_USEAST_AGs-1.298.0.20240717-102919.sh