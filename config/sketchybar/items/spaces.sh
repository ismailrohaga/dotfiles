#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Add the aerospace workspace change event
sketchybar --add event aerospace_workspace_change

# Create spaces for each workspace
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=$ITEM_BG_COLOR \
        background.corner_radius=5 \
        background.height=24 \
        background.drawing=off \
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="$HOME/.config/sketchybar/plugins/aerospace.sh $sid"
done

sketchybar --add item space_separator left \
  --set space_separator icon="􀆊" \
  icon.color="$ACCENT_COLOR" \
  icon.padding_left=4 \
  label.drawing=off \
  background.drawing=off
