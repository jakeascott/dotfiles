for user services put service files in ~/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user start|enable|disable|stop foo.service|timer 
