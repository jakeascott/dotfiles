You don't need to use i3 with a DE. It works great on it's own - you kind of make your own DE out of it. Takes a little more work, sure, but you end up with a lighter system overall because you're only running the things you absolutely need to. So I'll break down how I take care of each of the things you're asking about. I use a laptop exclusively, so some things may be specific to laptop usage. I'll link some things to the Arch Wiki, but much of the information also applies to other distros as well.

**Sleep/Power Management:**
Set it and forget it with [TLP](https://wiki.archlinux.org/index.php/TLP) and [autosuspend](https://github.com/languitar/autosuspend)

**Network Manager:**
[NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager) - start the applet with `exec --no-startup-id nm-applet &` in your config. If you don't want any issues with saving wifi passwords, you'll have to set up an [authentication agent](https://wiki.archlinux.org/index.php/Polkit).

**Sound Indicator:**
Since you're already using i3, you could simply use the built-in indicator in i3bar/i3blocks. Personally, I'm using [polybar](https://github.com/jaagr/polybar) instead. There are several choices if you want an indicator that runs in the tray instead. I haven't used one of those in quite a while, so I can't even remember which one I liked. You have several options, though. Perhaps someone else could jump in with a recommendation.

**Screen Management:**
This is where things get fun. I use a daemon that was initially to take care of `xrandr` alone, but it ended up expanding a bit to take care of other things. At it's core, it's basically constantly monitoring the HDMI port of my laptop. When the cable is plugged in, a series of commands are run. Same thing when disconnecting, but doing the opposite commands. I only use one screen at a time, so the laptop display gets turned off while the external monitor is enabled, and vice versa upon disconnection. I have my speakers plugged into the back of my monitor, so the sound switches to HDMI as well, and back to the laptop speaker when HDMI is disconnected. Finally, since my laptop and monitor have different resolutions (1600x900 and 1920x1080), the wallpaper gets reset (using [feh](https://wiki.archlinux.org/index.php/feh), by the way). You'll also need `xev` if you decide to use this. Of course, it can be modified to fit your needs.

    #!/usr/bin/env sh
    #
    # Credit to gurkensalat
    # https://faq.i3wm.org/question/6421/conditional-monitor-cofiguration.1.html
    #

    onConnection() {
        echo onConnection
        xrandr --output HDMI-1 --auto
        xrandr --output LVDS-1 --off
        pacmd set-card-profile 0 "output:hdmi-stereo+input:analog-stereo"
        feh --bg-fill ~/.i3/res/wallpaper.png
    }
    onDisconnection() {
        echo onDisconnection
        xrandr --output LVDS-1 --auto
        xrandr --output HDMI-1 --off
        pacmd set-card-profile 0 "output:analog-stereo+input:analog-stereo"
        feh --bg-fill ~/.i3/res/wallpaper.png
    }

    #########################

    statefile="`mktemp`"

    quit() {
        rm "$statefile"
        exit 1
    }
    trap quit SIGINT SIGTERM

    getstate() {
        state="`xrandr -q | wc -l`"
    }
    savestate() {
        echo "$state" > "$statefile"
    }
    getstate
    savestate

    xev -root -event randr | grep --line-buffered XRROutputChangeNotifyEvent | \
    while IFS= read -r line; do
        getstate
        old="`cat "$statefile"`"
        if [ "$state" -gt "$old" ]; then
            onConnection
        elif [ "$state" -lt "$old" ]; then
            onDisconnection
        fi
        savestate
    done

**Auto-mounting Drives:**
Along with some `fstab` rules, I use [udiskie](https://github.com/coldfix/udiskie) which makes it pretty seamless.

**Wallpaper Management:**
I already mentioned `feh` above. Whenever I wish to change my wallpaper, I can drop one in a folder and press a hotkey which runs a script to switch to that wallpaper. The script simply moves the image to the correct location and converts it to PNG, also giving it the proper filename. This is to ensure the xrandr daemon continues to work. Pay attention to the part of the script where `rm -rf` is used - that's a dangerous command, so make sure the folder you're dropping new wallpapers into is empty! The convert command requires `imagemagick` to be installed.

    #!/bin/bash

    # Copy new wallpaper to ~/.i3/res/new-wallpaper/ ($NEW)
    # Image format and file name doesn't matter
    # Caution: $NEW will be deleted afterwards!

    NEW=$HOME/.i3/res/new-wallpaper/*.*
    WALLPAPER=$HOME/.i3/res/wallpaper.png

    convert $NEW $WALLPAPER
    feh --bg-fill $WALLPAPER
    rm -rf $NEW

**Other:**

[Rofi](https://wiki.archlinux.org/index.php/Rofi) - For all sorts of pop-up menus, whether to open applications, display a shutdown menu, and even clipboard management. Speaking of which, that requires [greenclip](https://github.com/erebe/greenclip).

I don't like my mouse pointer being displayed unless I'm using my mouse. [unclutter](https://github.com/Airblader/unclutter-xfixes) takes care of that.

I use [xbindkeys](https://wiki.archlinux.org/index.php/Xbindkeys) for opening applications and launching some scripts, as it's not bound to the window manager, making it easy to switch.

Are you seeing screen tearing in i3? Most DE's have their own screen compositor. i3, and most other bare WM's do not. [compton](https://wiki.archlinux.org/index.php/Compton) solves that issue in no time.

Desktop environments also have their own notification system - i3 does not. There's a few options to choose from, and I like [twmn](https://github.com/sboli/twmn).

All of this should at least take care of the basics. If you have any questions, feel free to ask.
