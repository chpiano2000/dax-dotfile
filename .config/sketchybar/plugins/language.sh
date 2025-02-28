#!/bin/bash

# Read the AppleSelectedInputSources and extract the relevant input source info
current_input_source=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)

# Check for "Input Mode"
input_mode=$(echo "$current_input_source" | grep -o '"Input Mode" = "[^"]*' | sed 's/"Input Mode" = "//')

# Check for "KeyboardLayout Name"
keyboard_layout=$(echo "$current_input_source" | grep Name | sed 's/.*= \(.*\);/\1/')

# Determine what to display based on what's available
if [ -n "$input_mode" ]; then
  label="VI"
elif [ -n "$keyboard_layout" ]; then
  label="A"
else
  label="Unknown"
fi

# Update the SketchyBar item with the current input source
sketchybar --set language label="$label"
