#!/bin/bash
#set -e


sudo mv -f /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter-old.conf
sudo touch /etc/lightdm/lightdm-gtk-greeter.conf
sudo bash -c 'echo "[greeter]
theme-name = Ant-Dracula
icon-theme-name = kora
background = /home/mm/backgrounds/arch.png" >> /etc/lightdm/lightdm-gtk-greeter.conf'
