#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

{%- if polybar.using_center == "true" %}
polybar -q center -c   ~/.config/polybar/config.ini &
{% endif -%}

{%- if polybar.using_left == "true" %}
polybar -q left -c   ~/.config/polybar/config.ini &
{% endif -%}

{%- if polybar.using_right == "true" %}
polybar -q right -c   ~/.config/polybar/config.ini &
{% endif -%}

