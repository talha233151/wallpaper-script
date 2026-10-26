#!/bin/bash

# Online wallpaper image URL
URL="https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1920"

# Download location
WALLPAPER="$HOME/Downloads/wallpaper.jpg"

# Download the wallpaper
curl -L "$URL" -o "$WALLPAPER"

# Check if download succeeded
if [ $? -eq 0 ] && file "$WALLPAPER" | grep -q "image"; then

    # Change the desktop wallpaper
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$WALLPAPER\""

    echo "Wallpaper changed successfully!"

else
    echo "Failed to download a valid wallpaper."
fi
