#!/bin/bash
set -euo pipefail

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
  exit
fi


########################
# General
########################

# Set dark theme
defaults write NSGlobalDomain AppleInterfaceStyle -string 'Dark'

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true


########################
# Mouse, Keyboard and Control Strip
########################

# Mouse: tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Control strip: show full control strip
defaults write com.apple.touchbar.agent PresentationModeGlobal -string fullControlStrip

# Control strip: set items
defaults write com.apple.controlstrip FullCustomized -array \
  "com.apple.system.group.brightness" \
  "com.apple.system.mission-control" \
  "com.apple.system.launchpad" \
  "com.apple.system.group.keyboard-brightness" \
  "com.apple.system.group.media" \
  "com.apple.system.group.volume" \
  "com.apple.system.screencapture"


########################
# Menu
########################

# Menu: show WiFi
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true

# Menu: show Sound
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true

# Menu: hide Bluetooth
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false

# Menu: show the battery
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

# Menu: show the Now Playing
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool true

# Menu: set item positions
defaults write com.apple.controlcenter "NSStatusItem Preferred Position BentoBox" -int 83
defaults write com.apple.controlcenter "NSStatusItem Preferred Position WiFi" -int 115
defaults write com.apple.controlcenter "NSStatusItem Preferred Position Battery" -int 151
defaults write com.apple.controlcenter "NSStatusItem Preferred Position Sound" -int 254

# Menu: display seconds in clock
defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults write com.apple.menuextra.clock ShowDate -int 2 # Never
defaults write com.apple.menuextra.clock DateFormat -string "HH:mm:ss"

# Menu: hide the day of the week
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false

# Menu: hide the date
defaults write com.apple.menuextra.clock ShowDayOfMonth -bool false


########################
# Finder
########################

# Finder: allow quitting via Cmd+Q
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: remove items from Trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Finder: set default path to the home dir
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Finder: hide recent tags in the sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


########################
# Dock
########################

# Dock: enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Dock: don't hide the Dock
defaults write com.apple.dock autohide -bool false

# Dock: set the icon size of Dock items to 50 pixels
defaults write com.apple.dock tilesize -int 50

# Dock: show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Dock: don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Dock: don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Dock: enable the Launchpad gesture
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Dock: minimise windows using scale effect
defaults write com.apple.dock mineffect -string scale

# Dock: minimise windows into application icon
defaults write com.apple.dock minimize-to-application -bool true


########################
# Messages
########################

# Messages: disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Messages: disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false


########################
# Other applications
########################

# iTerm2: set custom configuration folder
defaults write com.googlecode.iterm2 PrefsCustomFolder "${HOME}/.config/iTerm2"

# iTerm2: enable loading configuration from custom folder
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Amphetamine: use cup icon
defaults write com.if.Amphetamine "Icon Style" -int 6

# Amphetamine: use low icon opacity
defaults write com.if.Amphetamine "Lower Icon Opacity" -bool true


########################
# Restart applications
########################

killall "ControlStrip" || true
killall "Dock"
killall "Finder"
