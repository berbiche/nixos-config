{ pkgs, ... }:

let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
in

{
  nixpkgs.overlays = [ moz_overlay ];

  environment.systemPackages = with pkgs; [

    wget curl aria
    
    colordiff
    
    git rsync
    
    exa fd fzf rofi ripgrep tree bc bat
    
    htop gotop ctop
    
    lsof
    
    nmap
    parted
    ranger stow
    
    traceroute telnet tcpdump whois dnsutils mtr
        
    neovim firefox-bin-unwrapped evince alacritty thunderbird libreoffice kitty
    latest.firefox-nightly-bin
    
    docker-compose
  ];
}
