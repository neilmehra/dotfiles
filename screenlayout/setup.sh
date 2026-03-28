#!/bin/sh
{% if "home" in profiles %}
xrandr --output {{ monitor.wide }} --primary --auto --rate 100 --output {{ monitor.left }} --auto --left-of {{ monitor.wide }} --output {{ monitor.main }} --auto --right-of {{ monitor.wide }}
{% elif "laptop" in profiles and "displaylink3" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }} --output {{ monitor.right }} --auto --right-of {{ monitor.main }}
{% elif "laptop" in profiles and "displaylink2" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144 --output {{ monitor.left }} --auto --left-of {{ monitor.main }}
{% elif "laptop" in profiles %}
xrandr --output {{ monitor.main }} --primary --mode 1920x1080 --pos 0x0 --rotate normal --rate 144
{% else %}
xrandr --output DVI-D-0 --off --output {{ monitor.left }} --mode 1920x1200 --pos 0x56 --rotate normal --output {{ monitor.main }} --mode 2560x1440 --pos 1920x0 --rotate normal --rate 144
{% endif %}
