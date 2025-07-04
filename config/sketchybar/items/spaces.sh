#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Add the aerospace workspace change event
sketchybar --add event aerospace_workspace_change

# Function to get app icons for a workspace
get_workspace_icons() {
  local workspace=$1
  local apps=$(aerospace list-windows --workspace "$workspace" --format '%{app-name}' 2>/dev/null | sort -u)
  local icon_strip=""
  
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      if [ -n "$app" ]; then
        local icon=$($HOME/.config/sketchybar/plugins/icon_map_fn.sh "$app")
        icon_strip+="$icon "
      fi
    done <<< "$apps"
    # Remove trailing space
    icon_strip=$(echo "$icon_strip" | sed 's/ *$//')
  else
    icon_strip="$workspace"
  fi
  
  echo "$icon_strip"
}

# Create spaces for each workspace
for sid in $(aerospace list-workspaces --all); do
  # Get initial icons for the workspace
  initial_icons=$(get_workspace_icons "$sid")
  
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
    background.color=$ITEM_BG_COLOR \
    background.corner_radius=5 \
    background.height=24 \
    background.drawing=off \
    label="$initial_icons" \
    label.padding_left=2 \
    label.padding_right=10 \
    label.font="SF Pro:Medium:16.0" \
    click_script="aerospace workspace $sid" \
    script="$HOME/.config/sketchybar/plugins/aerospace.sh $sid"
done

sketchybar --add item space_separator left \
  --set space_separator icon="􀆊" \
  icon.color="$ACCENT_COLOR" \
  icon.padding_left=4 \
  label.drawing=off \
  background.drawing=off
