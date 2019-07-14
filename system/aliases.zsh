# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Add macos alias
if test "$(uname)" = "Darwin"
then
  # Check, clear, set (Google DNS or Cloudflare DNS or custom), and flush your computer’s DNS, overriding your router
  alias dns-check="networksetup -getdnsservers Wi-Fi"
  alias dns-clear="networksetup -setdnsservers Wi-Fi empty"
  alias dns-flush="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"
  alias dns-set-custom="networksetup -setdnsservers Wi-Fi "   # example: dns-set-custom 208.67.222.222 208.67.220.220
  alias dns-set-cloudflare="networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001"
  alias dns-set-google="networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4 2001:4860:4860::8888 2001:4860:4860::8844"

  # Check your current IP address (IPv4 or IPv6)
  alias ip4="dig +short myip.opendns.com A @resolver1.opendns.com"
  alias ip6="dig +short -6 myip.opendns.com AAAA @resolver1.ipv6-sandbox.opendns.com"

  # Check your current local IP address
  alias iplocal="ipconfig getifaddr en0"

  # Quickly lock your screen by starting screensaver on macOS
  alias afk="/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
fi

# Good 'ol Clear Screen command
alias cls='clear'
