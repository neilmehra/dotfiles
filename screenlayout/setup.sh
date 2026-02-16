#!/bin/sh


{% if "laptop" in profiles %}

{% if "displaylink2" in profiles %}

xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }}

{% elif "displaylink3" in profiles %}

xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }} --output {{ monitor.right }} --auto --right-of {{ monitor.main }}

{% elif "laptophome" in profiles %}

xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }}

{% else %}

xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144

{% endif %}

{% else %}

xrandr --output DVI-D-0 --off --output {{ monitor.left }} --mode 1920x1200 --pos 0x56 --rotate normal --output {{ monitor.main }} --mode 2560x1440 --pos 1920x0 --rotate normal --rate 144

{% endif %}


