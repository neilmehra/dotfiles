#!/bin/sh

{% if mpd.using == "true" %}
mpd &
{% endif %}

clipster -d &

~/scripts/setbg.sh &
~/.config/polybar/launch.sh &
~/scripts/xautostart.sh
