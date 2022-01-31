#!/bin/bash

case "${1}" in
    "0") #off
    echo "${1}" > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 0 > /sys/class/leds/green/brightness
    echo 0 > /sys/class/leds/blue/brightness
    ;;
    "1") #red
    echo "${1}" > /var/local/led.state
    echo 1 > /sys/class/leds/red/brightness
    echo 0 > /sys/class/leds/green/brightness
    echo 0 > /sys/class/leds/blue/brightness
    ;;
    "2") #green
    echo "${1}" > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 1 > /sys/class/leds/green/brightness
    echo 0 > /sys/class/leds/blue/brightness
    ;;
    "3") #blue
    echo "${1}" > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 0 > /sys/class/leds/green/brightness
    echo 1 > /sys/class/leds/blue/brightness
    ;;
    "4") #white
    echo "${1}" > /var/local/led.state
    echo 1 > /sys/class/leds/red/brightness
    echo 1 > /sys/class/leds/green/brightness
    echo 1 > /sys/class/leds/blue/brightness
    ;;
    "5") #purple
    echo "${1}" > /var/local/led.state
    echo 1 > /sys/class/leds/red/brightness
    echo 0 > /sys/class/leds/green/brightness
    echo 1 > /sys/class/leds/blue/brightness
    ;;
    "6") #yellow
    echo "${1}" > /var/local/led.state
    echo 1 > /sys/class/leds/red/brightness
    echo 1 > /sys/class/leds/green/brightness
    echo 0 > /sys/class/leds/blue/brightness
    ;;
    "7") #cyan
    echo "${1}" > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 1 > /sys/class/leds/green/brightness
    echo 1 > /sys/class/leds/blue/brightness
    ;;
    "-1") #cyan
    echo 7 > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 1 > /sys/class/leds/green/brightness
    echo 1 > /sys/class/leds/blue/brightness
    ;;
    *) #off
    echo 0 > /var/local/led.state
    echo 0 > /sys/class/leds/red/brightness
    echo 0 > /sys/class/leds/green/brightness
    echo 0 > /sys/class/leds/blue/brightness
    ;;
    esac
