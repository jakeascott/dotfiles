#!/bin/sh
# configures touchpad for xorg, run as root

echo 'Enabling touchpad for x...'
mkdir -vp /etc/X11/xorg.conf.d
cat > /etc/X11/xorg.conf.d/90-touchpad.conf << 'EOF'
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
    Option "NaturalScrolling" "on"
    Option "ScrollMethod" "twofinger"
EndSection
EOF
