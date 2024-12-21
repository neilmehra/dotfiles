#!/bin/bash
rogauracore initialize_keyboard
rogauracore magenta
rogauracore brightness 3
sleep 3
~/scripts/xautostart.sh
xmodmap ~/.Xmodmap
