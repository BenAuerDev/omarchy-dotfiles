# Omarchy Customizations

This repository contains customizations for the Omarchy Hyprland setup, including vim-style window management, AI prompt management, and development tool integrations.

## Features

- **Vim-style window management** - Move and resize windows with hjkl keys
- **Archivist AI prompts manager** - Quick access to frequently used text snippets
- **Android Studio emulator fixes** - Proper scaling and display
- **Chrome executable configuration** - For development tools
- **JetBrains IDE window rules** - Dedicated workspace with floating windows
- **Custom keybindings** - Optimized for productivity

## Quick Setup

1. **Clone this repository**:

   ```bash
   git clone <your-repo-url> ~/omarchy-dotfiles
   cd ~/omarchy-dotfiles
   ```

2. **Run the setup script**:

   ```bash
   ./setup.sh
   ```

3. **Reload Hyprland**: Press `SUPER + CTRL + R`

4. **Reload shell**: `source ~/.zshrc`

## Keybindings

### Application Launchers

- **SUPER + A** = Archivist (AI prompts manager)
- **SUPER + B** = Browser
- **SUPER + C** = Calendar
- **SUPER + E** = File manager (Nautilus)
- **SUPER + G** = Signal
- **SUPER + M** = Music (Spotify)
- **SUPER + N** = Editor
- **SUPER + O** = Obsidian
- **SUPER + Q** = Close active window
- **SUPER + T** = Activity (btop)
- **SUPER + Y** = YouTube
- **SUPER + /** = Passwords (1Password)

### Window Management (Vim-style)

- **SUPER + hjkl** = Move focus
- **SUPER SHIFT + hjkl** = Move windows
- **SUPER ALT + hjkl** = Resize windows

### Moved Keybindings

- **SUPER + I** = Toggle split (was SUPER + J)
- **SUPER + U** = Show key bindings (was SUPER + K)

### Web Apps

- **SUPER SHIFT + A** = Grok
- **SUPER SHIFT + G** = WhatsApp
- **SUPER ALT + G** = Google Messages
- **SUPER SHIFT + X** = X Post

## Archivist Usage

1. **Create prompts**: Store text files in `~/prompts/` with `.txt`, `.md`, or `.prompt` extensions
2. **Access prompts**: Press `SUPER + A` to open the Walker menu
3. **Edit prompts**: Select "Open in Neovim" to edit your prompts
4. **Copy to clipboard**: Select any prompt to copy it to clipboard

### Creating New Prompts

**Method 1: Using nvim (recommended)**

1. Press `SUPER + A` → "Open in Neovim"
2. Type `:e ~/prompts/your_filename.txt`
3. Write your prompt content
4. Save with `:w` and exit with `:q`

**Method 2: From terminal**

```bash
echo "Your prompt content here" > ~/prompts/your_filename.txt
```

## File Structure

```
omarchy-dotfiles/
├── README.md              # This file
├── setup.sh              # Setup script
├── .zshrc                 # Shell configuration
└── hypr/
    ├── bindings.conf      # Custom keybindings
    ├── envs.conf          # Environment variables
    ├── windows.conf       # Window rules
    └── archivist.sh       # AI prompts manager script
```

## Dependencies

- Omarchy (Hyprland setup)
- Walker (launcher)
- wl-copy (clipboard)
- nautilus (file manager)
- nvim/vim (editor)
- nwg-displays (display management)

## Customizations Included

### Window Management

- Complete vim-style window management (focus, move, resize)
- JetBrains IDEs use dedicated floating workspace
- Android emulator proper sizing and centering
- Resolved keybinding conflicts with Omarchy defaults

### Development Tools

- Chrome executable properly configured
- Android Studio emulator scaling fixes
- Environment variables for proper display scaling

### AI Prompt Management

- Walker-integrated prompt manager
- Clipboard integration
- Neovim editing support
- File manager integration

## Troubleshooting

### Clipboard not working

- Ensure `wl-copy` is installed
- Check that you're using plain text files (not binary files)

### Neovim not opening

- Verify `nvim` is installed
- Check that `$TERMINAL` is set correctly (should be `alacritty`)

### Keybindings not working

- Reload Hyprland: `SUPER + CTRL + R`
- Check for conflicts in keybinding files

## Contributing

Feel free to submit issues or pull requests to improve these customizations.

## License

This project is open source and available under the MIT License.
