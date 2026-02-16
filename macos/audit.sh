#!/bin/bash
# Audit macOS defaults — compares defaults.sh settings against current machine

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

mismatch_count=0
match_count=0

section() {
	printf "\n${BOLD}$1${RESET}\n\n"
}

check() {
	local description="$1"
	local domain="$2"
	local key="$3"
	local expected="$4"
	local read_cmd="$5"

	if [ -z "$read_cmd" ]; then
		actual=$(defaults read "$domain" "$key" 2>/dev/null || echo "NOT SET")
	else
		actual=$(eval "$read_cmd" 2>/dev/null || echo "NOT SET")
	fi

	# Normalize for comparison
	local exp_cmp="$expected"
	local act_cmp="$actual"

	# Map bool strings to 0/1
	case "$exp_cmp" in true|TRUE) exp_cmp="1" ;; false|FALSE) exp_cmp="0" ;; esac

	# Normalize floats
	if [[ "$exp_cmp" =~ ^[0-9.]+$ && "$act_cmp" =~ ^[0-9.]+$ ]]; then
		exp_cmp=$(printf "%.1f" "$exp_cmp")
		act_cmp=$(printf "%.1f" "$act_cmp")
	fi

	# Normalize paths
	exp_cmp="${exp_cmp/#~\//$HOME/}"
	act_cmp="${act_cmp/#~\//$HOME/}"

	# Normalize whitespace
	exp_cmp=$(echo "$exp_cmp" | tr -s '[:space:]' ' ' | xargs)
	act_cmp=$(echo "$act_cmp" | tr -s '[:space:]' ' ' | xargs)

	local display_actual=$(echo "$actual" | tr -s '[:space:]' ' ' | xargs)

	if [ "$exp_cmp" = "$act_cmp" ]; then
		printf "  ${GREEN}✓${RESET}  %-40s ${DIM}%-20s${RESET} = ${GREEN}%-15s${RESET}\n" "$description" "$expected" "$display_actual"
		match_count=$((match_count + 1))
	else
		printf "  ${RED}✗${RESET}  %-40s ${DIM}%-20s${RESET} ≠ ${YELLOW}%-15s${RESET}\n" "$description" "$expected" "$display_actual"
		mismatch_count=$((mismatch_count + 1))
	fi
}

printf "\n${BOLD}macOS Defaults Audit${RESET}\n"
printf "Comparing defaults.sh settings against this machine\n"
printf "${DIM}%-45s %-20s   %-15s${RESET}\n" "" "defaults.sh" "This machine"

# --- General UI/UX ---
section "General UI/UX"
check "Save to disk, not iCloud"              NSGlobalDomain NSDocumentSaveNewDocumentsToCloud false
check "Auto-capitalization"                   NSGlobalDomain NSAutomaticCapitalizationEnabled false
check "Smart dashes"                          NSGlobalDomain NSAutomaticDashSubstitutionEnabled false
check "Smart quotes"                          NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled false
check "Auto-period insertion"                 NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled false

# --- Menu bar ---
section "Menu Bar"
check "Clock format"                          com.apple.menuextra.clock DateFormat "EEE d MMM  HH:mm:ss"
check "Battery control center"                com.apple.controlcenter Battery 18 "defaults -currentHost read com.apple.controlcenter Battery"
check "Show battery percentage"               com.apple.controlcenter BatteryShowPercentage 1 "defaults -currentHost read com.apple.controlcenter BatteryShowPercentage"

# --- Trackpad & Keyboard ---
section "Trackpad & Keyboard"
check "Tap to click (trackpad)"               com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking true
check "Tap to click (global)"                 NSGlobalDomain com.apple.mouse.tapBehavior 1
check "Full keyboard access"                  NSGlobalDomain AppleKeyboardUIMode 3
check "Press-and-hold for accents"            NSGlobalDomain ApplePressAndHoldEnabled false
check "Key repeat rate"                       NSGlobalDomain KeyRepeat 1
check "Initial key repeat delay"              NSGlobalDomain InitialKeyRepeat 12

# --- Locale ---
section "Locale"
check "Measurement units"                     NSGlobalDomain AppleMeasurementUnits Centimeters
check "Use metric units"                      NSGlobalDomain AppleMetricUnits true

# --- Screen ---
section "Screen"
check "Password after screensaver"            com.apple.screensaver askForPassword 1
check "Password delay (seconds)"              com.apple.screensaver askForPasswordDelay 0
check "Screenshot location"                   com.apple.screencapture location "$HOME/Desktop/screenshots"

# --- Finder ---
section "Finder"
check "Show hidden files"                     com.apple.finder AppleShowAllFiles true
check "New window opens home"                 com.apple.finder NewWindowTarget PfHm
check "Show all filename extensions"          NSGlobalDomain AppleShowAllExtensions true
check "Show status bar"                       com.apple.finder ShowStatusBar true
check "Show path bar"                         com.apple.finder ShowPathbar true
check "Folders on top when sorting"           com.apple.finder _FXSortFoldersFirst true
check "Search current folder"                 com.apple.finder FXDefaultSearchScope SCcf
check "Extension change warning"              com.apple.finder FXEnableExtensionChangeWarning false
check "Spring-loaded directories"             NSGlobalDomain com.apple.springing.enabled true
check "Skip .DS_Store on network"             com.apple.desktopservices DSDontWriteNetworkStores true
check "Skip .DS_Store on USB"                 com.apple.desktopservices DSDontWriteUSBStores true
check "List view by default"                  com.apple.finder FXPreferredViewStyle Nlsv

# --- Dock ---
section "Dock"
check "Icon size (36px)"                      com.apple.dock tilesize 36
check "Spring loading for Dock items"         com.apple.dock enable-spring-load-actions-on-all-items true
check "Show open app indicators"              com.apple.dock show-process-indicators true
check "Launch animation"                      com.apple.dock launchanim false
check "Fast Mission Control animation"        com.apple.dock expose-animation-duration 0.1
check "Rearrange Spaces by usage"             com.apple.dock mru-spaces false
check "Autohide delay (seconds)"              com.apple.dock autohide-delay 0
check "Instant Dock show/hide"                com.apple.dock autohide-time-modifier 0
check "Autohide Dock"                         com.apple.dock autohide true
check "Translucent hidden app icons"          com.apple.dock showhidden true
check "Recent apps in Dock"                   com.apple.dock show-recents false

# --- Hot corners ---
section "Hot Corners"
check "Top-left → Mission Control"            com.apple.dock wvous-tl-corner 2
check "Top-left modifier"                     com.apple.dock wvous-tl-modifier 0
check "Top-right → Desktop"                   com.apple.dock wvous-tr-corner 4
check "Top-right modifier"                    com.apple.dock wvous-tr-modifier 0
check "Bottom-right → App Windows"            com.apple.dock wvous-br-corner 3
check "Bottom-right modifier"                 com.apple.dock wvous-br-modifier 0

# --- Safari ---
section "Safari"
check "Enable Develop menu"                   com.apple.Safari IncludeDevelopMenu true
check "WebKit Developer Extras"               NSGlobalDomain WebKitDeveloperExtras true
check "Safari auto-correct"                    com.apple.Safari WebAutomaticSpellingCorrectionEnabled false

# --- Terminal ---
section "Terminal"
check "UTF-8 encoding"                        com.apple.Terminal StringEncodings "( 4 )" "defaults read com.apple.Terminal StringEncodings 2>/dev/null"

# --- Activity Monitor ---
section "Activity Monitor"
check "CPU usage in Dock icon"                com.apple.ActivityMonitor IconType 5
check "Sort by CPU usage"                     com.apple.ActivityMonitor SortColumn CPUUsage
check "Sort direction (descending)"           com.apple.ActivityMonitor SortDirection 0

# --- Photos ---
section "Photos"
check "Disable Photos auto-open on plug-in"   com.apple.ImageCapture disableHotPlug true "defaults -currentHost read com.apple.ImageCapture disableHotPlug"

# --- Chrome ---
section "Chrome"
check "Chrome trackpad back-swipe"            com.google.Chrome AppleEnableSwipeNavigateWithScrolls false
check "Chrome mouse back-swipe"               com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls false

# --- Summary ---
printf "\n"
printf "  ${GREEN}✓ %d match${RESET}  ${RED}✗ %d differ${RESET}\n\n" "$match_count" "$mismatch_count"
