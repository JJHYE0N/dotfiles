FAVORITE=(
	"google-chrome.desktop"
	"steam.desktop"
	"com.vinszent.GnomeTwitch.desktop"
	"rhythmbox.desktop"
	"smplayer.desktop"
	"shotwell.desktop"
	"st.desktop"
	"org.gnome.Nautilus.desktop"
	"org.gnome.tweaks.desktop"
	"gnome-control-center.desktop"
	"nvidia-settings.desktop"
)
#
# Favorites
#
for app in ${FAVORITE[*]}; do
	gset="${gset:+"${gset}, "}'${app}'"
done
gsettings set org.gnome.shell favorite-apps "[${gset[*]}]"

#
# Desktop
#
gsettings set org.gnome.desktop.background show-desktop-icons 'false'
gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.desktop.screensaver picture-options 'scaled'
gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
gsettings set org.gnome.desktop.interface clock-show-date 'true'
gsettings set org.gnome.desktop.interface clock-show-seconds 'true'

#
# Extensions
#
SCHEMADIR="$HOME/.local/share/gnome-shell/extensions"

for dir in $SCHEMADIR/dash-to-dock*; do
	if [ -d "$dir" ]; then
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock apply-custom-theme 'false'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink 'true'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock customize-alphas true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock background-opacity 0.3
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock max-alpha 0.2

		# <Super>Q: dash-to-dock
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock hot-keys false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock shortcut-text ""
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock shortcut "[]"

		# Set all false to hide ubuntu dash-to-dock
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock autohide false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock dock-fixed false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.dash-to-dock intellihide true
	fi
	break
done

for dir in $SCHEMADIR/caffeine*; do
	if [ -d "$dir" ]; then
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.caffeine user-enabled true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.caffeine enable-fullscreen true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.caffeine show-indicator true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.caffeine restore-state true
	fi
	break
done

for dir in $SCHEMADIR/no-title-bar*; do
	if [ -d "$dir" ]; then
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.no-title-bar change-appmenu false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.no-title-bar button-position 'hidden'
	fi
	break
done

for dir in $SCHEMADIR/openweather*; do
	if [ -d "$dir" ]; then
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather weather-provider 'openweathermap'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather center-forecast false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather days-forecast 2
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather unit 'celsius'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather geolocation-provider 'openstreetmaps'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather menu-alignment 75.0
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather actual-city 0
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather use-default-owm-key true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather show-text-in-panel true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather show-comment-in-panel false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather location-text-length 0
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather position-in-panel 'right'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather appid-fc ''
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather refresh-interval-forecast 3600
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather city '37.5666791,126.9782914>서울, 대한민국 >-1'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather appid ''
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather translate-condition true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather refresh-interval-current 600
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather use-text-on-buttons false
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather wind-direction true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather use-symbolic-icons true
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather pressure-unit 'hPa'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather geolocation-appid-mapquest ''
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather decimal-places 1
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather wind-speed-unit 'm/s'
		gsettings --schemadir "$dir/schemas" set org.gnome.shell.extensions.openweather show-comment-in-forecast true
	fi
	break
done

#
# Theme
# 
gsettings set org.gnome.desktop.interface gtk-theme "Adapta-Eta"
gsettings set org.gnome.desktop.interface icon-theme "Suru++"
gsettings set org.gnome.desktop.interface cursor-theme "DMZ-Black"
gsettings set org.gnome.shell.extensions.user-theme name "Adapta-Eta"

#
# Keyboard shortcuts
# 
gsettings set org.gnome.desktop.input-sources xkb-options "['korean:ralt_rctrl', 'caps:escape']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home '<Super>e'

# Disable default bindings.
# <Super>: overlay key
gsettings set org.gnome.mutter overlay-key ""
# <Super>N: focus-active-notification
gsettings set org.gnome.shell.keybindings focus-active-notification "[]"
# <Super>H: Hide window
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
# <Super>L: Screensaver
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"
# <Super>P: switch-monitor
gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
# <Super>P: video out
gsettings set org.gnome.settings-daemon.plugins.media-keys video-out "[]"
# <Super>Above_Tab: switch-group
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Alt>Above_Tab']"
# <Super>S: toggle-overview
gsettings set org.gnome.shell.keybindings toggle-overview "[]"

# Window tiling keybindings
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Super>H']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Super>L']"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>K']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>J']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>M']"

# Switching workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>N']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>P']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Left']"
# gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Right']"

# Move window to another workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Super><Ctrl>N']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Super><Ctrl>P']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Alt>Right']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Alt>Left']"

# Move window to another monitor
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super><Ctrl>H']"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Super><Ctrl>L']"

# Minimize window
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>M']"
# Close window
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>Q', '<Alt>F4']"
# Disable animation
gsettings set org.gnome.desktop.interface enable-animations true
# Text ellipsis limit
gsettings set org.gnome.nautilus.desktop text-ellipsis-limit 1
gsettings set org.gnome.nautilus.icon-view text-ellipsis-limit "['1']"

# Switching to specific workspace
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super>9']"

# Move window to specific workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Ctrl>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Ctrl>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Ctrl>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Ctrl>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super><Ctrl>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Ctrl>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super><Ctrl>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super><Ctrl>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Super><Ctrl>9']"

# Sound control
# Unlike 'wm', media-keys does not support
# list of multiple keys, but string only.
# Thus, the audio keys, such as 'XF86AudioRaiseVolume',
# which some keyboards have will be disabled.
# I have tried to bind these keys to custom-keybindings to run 'amixer',
# but it did not go well. The commands were:
# 'amixer set Master 3%+'
# 'amixer -q sset Master 3%+'
# 'amixer -q -D pulse sset Master 10%+'
# 'amixer -M get Master'
# 'pactl set-sink-volume 0 +15%'
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "<Super>equal"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "<Super>minus"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "<Super>0"

# Customized shortcuts
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[\
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/', \
	'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/' ]"

# custom0: Shutdown
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Shutdown"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "gnome-session-quit --power-off"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>grave"

# custom1: gnome-tweaks
# ubuntu 18.04 has bug that it cannot bind "<Super>O".
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Gnome Tweaks"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "gnome-tweaks"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Super>U"

# custom2: Calculator
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "Calculator"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "gnome-calculator"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Super>C"

# custom3: Simple Terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name "Simple Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command "st"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding "<Super>Return"

# custom4: Ranger
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ name "Ranger"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ command "st -e 'ranger'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/ binding "<Super>R"

# custom5: Dmenu
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ name "Dmenu"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ command "dmenu_run"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/ binding "<Super>S"

# custom6: Web browser
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ name "Web browser"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ command "google-chrome"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/ binding "<Super>W"

# custom7: Music Player
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ name "Music Player"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ command "rhythmbox"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ binding "<Super>Y"

# custom8: Twitch TV
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ name "Twitch"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ command "gnome-twitch"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ binding "<Super>T"

# custom9: Steam
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ name "Steam"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ command "steam"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ binding "<Super>G"

# custom10: nvidia
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ name "Nvidia dmenu"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ command "$DIR/nvidia.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ binding "<Super>semicolon"

