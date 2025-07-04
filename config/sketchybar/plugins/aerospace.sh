#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

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

# Update all workspace icons
update_all_workspaces() {
  for workspace in $(aerospace list-workspaces --all); do
    local icons=$(get_workspace_icons "$workspace")
    sketchybar --set space.$workspace label="$icons"
  done
}

# Handle workspace change events
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi

# Update icons for all workspaces when any change occurs
update_all_workspaces
