. "$HOME/.asdf/asdf.sh"

# Add Google Chrome to PATH
export PATH="/usr/bin:$PATH"

# Set Chrome executable for development tools
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Fix terminal compatibility for starship
export TERM="xterm-256color"

# Show system info on terminal startup
fastfetch

# Initialize starship prompt
eval "$(starship init zsh)"

# Useful aliases
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias -- -='cd -'
