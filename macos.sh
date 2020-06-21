#!/bin/bash

if [[ ! "$OSTYPE" =~ ^darwin ]]; then
  exit
fi


# Set dark theme
defaults write NSGlobalDomain AppleInterfaceStyle -string 'Dark'

# Finder: allow quitting via Cmd+Q
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

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


killall "Dock"
killall "Finder"
