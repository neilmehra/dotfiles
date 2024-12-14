#!/bin/sh

{% if mpd.using == "true" %}
mpd &
{% endif %}


{% if picom.using == "true" %}
pkill picom && picom --experimental-backend --refresh-rate 144 --xrender-sync-fence &
{% endif %}

clipster -d &

$HOME/scripts/setbg.sh &
$HOME/.config/polybar/launch.sh &
$HOME/scripts/xautostart.sh
