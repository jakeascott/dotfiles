#!/bin/sh
# Requires package 'xorg-server-xephyr'
Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome
