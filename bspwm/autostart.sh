#!/bin/sh

{% if mpd.using == "true" %}
mpd &
{% endif %}

clipster -d &

$HOME/scripts/setbg.sh &
$HOME/.config/polybar/launch.sh &
$HOME/scripts/xautostart.sh
