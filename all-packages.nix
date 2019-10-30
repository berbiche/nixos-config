{ pkgs, ... }:

{
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
        
    neovim firefox evince alacritty thunderbird libreoffice kitty
    
    docker-compose wireguard
  ];
}
