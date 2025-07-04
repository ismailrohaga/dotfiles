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

# Update specific workspace icons
update_workspace() {
  local workspace=$1
  local icons=$(get_workspace_icons "$workspace")
  sketchybar --set space.$workspace label="$icons"
}

# Update all workspace icons with debouncing
update_all_workspaces() {
  local pid_file="/tmp/sketchybar_aerospace_update.pid"
  
  # Kill any existing background update process
  if [ -f "$pid_file" ]; then
    local old_pid=$(cat "$pid_file")
    kill "$old_pid" 2>/dev/null || true
    rm -f "$pid_file"
  fi
  
  # Start new background update process
  (
    echo $$ > "$pid_file"
    # Small delay to let aerospace complete the workspace switch
    sleep 0.15
    
    # Get current focused workspace to update it first for immediate feedback
    local focused_workspace=$(aerospace list-workspaces --focused)
    if [ -n "$focused_workspace" ]; then
      update_workspace "$focused_workspace"
    fi
    
    # Then update all other workspaces
    for workspace in $(aerospace list-workspaces --all); do
      if [ "$workspace" != "$focused_workspace" ]; then
        update_workspace "$workspace"
      fi
    done
    
    rm -f "$pid_file"
  ) &
}

# Handle workspace change events - immediate UI feedback
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi

# Update workspace icons (debounced and backgrounded)
update_all_workspaces
