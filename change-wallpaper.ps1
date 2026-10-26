
#!/bin/bash

# Allowed client IPs
ALLOWED_IPS=("10.120.170.106" "10.120.149.201")

# Get this device's current IP address
MY_IP=$(ipconfig getifaddr en0)

# Check whether this device is allowed
ALLOWED=false
for IP in "${ALLOWED_IPS[@]}"; do
    if [ "$MY_IP" = "$IP" ]; then
        ALLOWED=true
        break
    fi
done

if [ "$ALLOWED" = false ]; then
    echo "This device is not authorized."
    exit 1
fi

echo "Device authorized: $MY_IP"

# Download wallpaper
IMAGE="$HOME/Downloads/wallpaper.jpg"
curl -L "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1920&q=80" -o "$IMAGE"

# Set macOS wallpaper
osascript -e "tell application \"System Events\" to set picture of every desktop to POSIX file \"$IMAGE\""

echo "Wallpaper changed successfully."
