mkdir -p ~/bin
cat > ~/bin/emopicker9000 <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

EMOJI_FILE="$HOME/.config/.emoji"

# Check emoji file exists
[[ -f "$EMOJI_FILE" ]] || {
  notify-send "emopicker9000" "Emoji file not found: $EMOJI_FILE"
  exit 1
}

# Show menu with wofi
chosen=$(cat "$EMOJI_FILE" | \
  wofi --show dmenu \
       --cache-file=/dev/null \
       --width=600 --height=400 \
       --prompt="Emoji:" \
       --allow-markup \
       --define=font="Fira Sans 14" | \
  awk '{print $1}'
)

# Exit if nothing chosen
[[ -z "$chosen" ]] && exit 0

if [[ -n "${1:-}" ]]; then
  # Type directly
  wtype "$chosen"
else
  # Copy to clipboard
  printf "%s" "$chosen" | wl-copy
  notify-send -i face-cool "emopicker9000" "'$chosen' copied to clipboard"
fi
EOF

chmod +x ~/bin/emopicker9000
