{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    histFile = "";

    # /etc/zsh/zprofile
    loginShellInit = ''
      export XDG_CONFIG_HOME=''${XDG_CONFIG_HOME:-$HOME/.config}
      export XDG_DATA_HOME=''${XDG_DATA_HOME:-$HOME/.local/share}
      export XDG_CACHE_HOME=''${XDG_CACHE_HOME:-$HOME/.cache}
      #export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_HOME/flatpak/exports/share:$PATH"
      
      export ZDOTDIR=''${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
      export HISTFILE="$XDG_DATA_HOME/zsh/history"
      
      autoload -Uz compinit
      compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
    '';

    # /etc/zsh/zshrc
    interactiveShellInit = ''
    '';
  };
}
