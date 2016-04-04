#!/bin/bash

#Proxy settings prompt
echo -e '\n----------------------\n Proxy settings (with credentials) \n--------------------\n'
read -p 'Proxy - login: ' loginProxy
read -p 'Proxy - password: ' passwdProxy
read -p 'Proxy - host: ' hostProxy
read -p 'Proxy - port: ' portProxy

#global proxy settings
proxy="http://$loginProxy"":""$passwdProxy""@""$hostProxy"":""$portProxy""/"
echo "export http_proxy=$proxy" >> /home/pi/.bashrc
echo "export https_proxy=$proxy" >> /home/pi/.bashrc

#apt proxy setting
sudo touch /etc/apt/apt.conf.d/99proxy
aptProxy="Acquire::http::Proxy \"$proxy\";"
echo $aptProxy | sudo tee -a /etc/apt/apt.conf.d/99proxy > /dev/null

#Update pi
sudo apt-get update && sudo apt-get upgrade

#DONE
echo "\n--------------------\n done, restart your pi with 'sudo reboot' \n---------------------\n"
