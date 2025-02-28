#!/bin/bash

sketchybar -m --add item ram_percentage right \
              --set ram_percentage label.font="Iosevka Nerd Font:Bold Italic:11.0" \
                                    icon= \
                                    script="~/.config/sketchybar/plugins/mem.sh" \
                                    update_freq=2
