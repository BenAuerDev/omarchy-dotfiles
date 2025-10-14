#!/bin/bash

# ================================================================
# ARCHIVIST - Quick Access to AI Prompts (Omarchy/Walker Version)
# ================================================================

# Ensure we have the right environment
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
export XDG_SESSION_TYPE="${XDG_SESSION_TYPE:-wayland}"
# 
# WHAT IT DOES:
# =============
# Provides quick access to frequently used text snippets stored as 
# text files. Press SUPER + A to open a Walker menu showing all 
# your text files, select one, and it gets copied to clipboard.
# 
# SETUP INSTRUCTIONS:
# ===================
# 1. This script is already configured and ready to use
# 2. Create text files in: ~/prompts/
# 3. Use .txt, .md, or .prompt extensions (e.g., code_review.txt, debug_help.md)
# 4. Keybinding: SUPER + A (already configured in keybindings)
# 5. Reload Hyprland: SUPER + CTRL + R
# 
# USAGE:
# ======
# - Press SUPER + A to open text menu
# - Select a text file → copies to clipboard
# - Paste anywhere you need it
# 
# FILE STRUCTURE:
# ===============
# ~/prompts/
# ├── code_review.txt
# ├── debug_help.md
# ├── explain_concept.prompt
# └── refactor_code.txt
# 
# This script integrates with Omarchy's Walker launcher
# ================================================================

# Configuration
PROMPTS_DIR="$HOME/prompts"
WALKER_CONFIG="$HOME/.config/walker/config.toml"

# Create prompts directory if it doesn't exist
mkdir -p "$PROMPTS_DIR"

# Function to show available prompts using Walker
show_prompts() {
    # Get all text files in the prompts directory (.txt, .md, .prompt)
    local prompts=()
    local prompt_names=()
    
    if [ -d "$PROMPTS_DIR" ]; then
        while IFS= read -r -d '' file; do
            # Get filename without extension
            local name
            name=$(basename "$file")
            # Remove common extensions
            for ext in .txt .md .prompt; do
                name="${name%$ext}"
            done
            # Replace underscores with spaces and capitalize
            local display_name
            display_name=$(echo "$name" | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
            
            prompts+=("$file")
            prompt_names+=("$display_name")
        done < <(find "$PROMPTS_DIR" \( -name "*.txt" -o -name "*.md" -o -name "*.prompt" \) -type f -print0 | sort -z)
    fi
    
    # If no prompts found, show message
    if [ ${#prompts[@]} -eq 0 ]; then
        notify-send "Archivist" "No prompts found in $PROMPTS_DIR\nCreate .txt files there to get started!" -t 5000
        return 1
    fi
    
    # Create menu options for Walker
    local menu_options=""
    for i in "${!prompt_names[@]}"; do
        menu_options+="${prompt_names[$i]}\n"
    done
    menu_options+="󰆍  Open in Neovim\n"
    menu_options+="📁  Open Prompts Folder"
    
    # Show Walker menu
    local chosen
    chosen=$(echo -e "$menu_options" | walker --dmenu --theme omarchy-default -p "Archivist" -w 600 -h 400)
    
    if [ -n "$chosen" ]; then
        # Check if user selected "Open in Neovim"
        if [ "$chosen" = "󰆍  Open in Neovim" ]; then
            open_in_neovim
        elif [ "$chosen" = "📁  Open Prompts Folder" ]; then
            open_prompts_folder
        else
            # Find the selected prompt file
            for i in "${!prompt_names[@]}"; do
                if [ "${prompt_names[$i]}" = "$chosen" ]; then
                    copy_prompt "${prompts[$i]}"
                    break
                fi
            done
        fi
    fi
}

# Function to copy prompt to clipboard
copy_prompt() {
    local file="$1"
    local content
    content=$(cat "$file")
    
    # Debug: show what we're trying to copy
    echo "DEBUG: Copying content from $file"
    echo "DEBUG: Content length: ${#content} characters"
    
    # Clear clipboard first to avoid issues
    wl-copy --clear 2>/dev/null || true
    
    # Copy to clipboard with proper environment
    if command -v wl-copy >/dev/null 2>&1; then
        # Use printf to ensure proper text handling
        printf '%s' "$content" | wl-copy
        if [ $? -eq 0 ]; then
            notify-send "Archivist" "Prompt copied to clipboard!" -t 2000
            echo "DEBUG: Successfully copied to clipboard"
        else
            notify-send "Archivist" "Failed to copy to clipboard" -t 3000
            echo "DEBUG: Failed to copy to clipboard"
        fi
    elif command -v xclip >/dev/null 2>&1; then
        printf '%s' "$content" | xclip -selection clipboard
        if [ $? -eq 0 ]; then
            notify-send "Archivist" "Prompt copied to clipboard!" -t 2000
        else
            notify-send "Archivist" "Failed to copy to clipboard" -t 3000
        fi
    else
        notify-send "Archivist" "No clipboard tool found (install wl-copy or xclip)" -t 3000
    fi
}

# Function to open prompts directory in neovim
open_in_neovim() {
    if command -v nvim >/dev/null 2>&1; then
        # Try direct terminal launch first
        $TERMINAL -e nvim "$PROMPTS_DIR" &
        if [ $? -ne 0 ]; then
            # Fallback to uwsm if direct launch fails
            uwsm app -- $TERMINAL -e nvim "$PROMPTS_DIR" &
        fi
    elif command -v vim >/dev/null 2>&1; then
        $TERMINAL -e vim "$PROMPTS_DIR" &
        if [ $? -ne 0 ]; then
            uwsm app -- $TERMINAL -e vim "$PROMPTS_DIR" &
        fi
    else
        notify-send "Archivist" "No editor found (install nvim or vim)" -t 3000
    fi
}

# Function to open prompts folder in file manager
open_prompts_folder() {
    uwsm app -- nautilus "$PROMPTS_DIR" &
}

# Test clipboard function
test_clipboard() {
    echo "Testing clipboard..."
    wl-copy --clear 2>/dev/null || true
    echo "Clipboard test" | wl-copy
    if [ $? -eq 0 ]; then
        notify-send "Archivist" "Clipboard test successful!" -t 2000
        echo "Clipboard test successful"
    else
        notify-send "Archivist" "Clipboard test failed!" -t 3000
        echo "Clipboard test failed"
    fi
}

# Test nvim function
test_nvim() {
    echo "Testing nvim launch..."
    echo "TERMINAL: $TERMINAL"
    echo "PROMPTS_DIR: $PROMPTS_DIR"
    
    if command -v nvim >/dev/null 2>&1; then
        echo "nvim found at: $(which nvim)"
        notify-send "Archivist" "Testing nvim launch..." -t 2000
        $TERMINAL -e nvim "$PROMPTS_DIR" &
        echo "Launched nvim"
    else
        echo "nvim not found"
        notify-send "Archivist" "nvim not found!" -t 3000
    fi
}

# Main function
main() {
    case "$1" in
        "create")
            open_in_neovim
            ;;
        "list")
            show_prompts
            ;;
        "folder")
            open_prompts_folder
            ;;
        "test")
            test_clipboard
            ;;
        "test-nvim")
            test_nvim
            ;;
        *)
            show_prompts
            ;;
    esac
}

# Run main function
main "$@"

