#!/bin/bash

# ================================================================
# Keyboard Layout Switcher - Toggle Mode (Omarchy Version)
# ================================================================
# 
# WHAT IT DOES:
# =============
# Toggles between German and UK English keyboard layouts
# Shows a nice overlay with the current layout
# 
# USAGE:
# ======
# - Run without arguments to toggle layout
# - Run with "overlay" to show current layout
# 
# KEYBINDING:
# ===========
# SUPER + O (already configured in keybindings)
# ================================================================

# Available layouts (add more here if needed)
layouts=("gb" "de")
layout_names=("🇬🇧 UK" "🇩🇪 German")

# Function to get current layout
get_current_layout() {
    hyprctl getoption input:kb_layout | grep 'str:' | awk '{print $2}'
}

# Function to get next layout index
get_next_layout_index() {
    local current
    current=$(get_current_layout)
    local current_index=0
    
    # Find current layout index
    for i in "${!layouts[@]}"; do
        if [ "${layouts[$i]}" = "$current" ]; then
            current_index=$i
            break
        fi
    done
    
    # Return next index (wrap around)
    echo $(((current_index + 1) % ${#layouts[@]}))
}

# Function to switch to specific layout
switch_to_layout() {
    local layout=$1
    
    hyprctl keyword input:kb_layout "$layout"
    # No notification - the overlay shows the current layout
}

# Function to show layout overlay using notify-send
show_layout_overlay() {
    local current
    current=$(get_current_layout)
    local current_index=0
    
    # Find current layout index
    for i in "${!layouts[@]}"; do
        if [ "${layouts[$i]}" = "$current" ]; then
            current_index=$i
            break
        fi
    done
    
    # Show notification with current layout
    local current_name="${layout_names[$current_index]}"
    notify-send "Keyboard Layout" "Current: $current_name" -t 2000 -i "input-keyboard"
}

# Main toggle function
toggle_layout() {
    local next_index
    next_index=$(get_next_layout_index)
    local next_layout="${layouts[$next_index]}"
    local next_name="${layout_names[$next_index]}"
    
    # Switch to next layout
    switch_to_layout "$next_layout" "$next_name"
    
    # Show overlay
    show_layout_overlay
}

# Function to cycle through layouts (for repeated key presses)
cycle_layout() {
    local current
    current=$(get_current_layout)
    local current_index=0
    
    # Find current layout index
    for i in "${!layouts[@]}"; do
        if [ "${layouts[$i]}" = "$current" ]; then
            current_index=$i
            break
        fi
    done
    
    # Get next layout
    local next_index=$(((current_index + 1) % ${#layouts[@]}))
    local next_layout="${layouts[$next_index]}"
    local next_name="${layout_names[$next_index]}"
    
    # Switch to next layout
    switch_to_layout "$next_layout" "$next_name"
    
    # Show overlay
    show_layout_overlay
}

# Check if we should show overlay only or cycle
if [ "$1" = "overlay" ]; then
    show_layout_overlay
else
    cycle_layout
fi
