{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    history.extended = true;

    initExtra = ''
      source ~/.nix-profile/etc/profile.d/nix.sh
      export PROMPT="%B%F{magenta}%n@%m%f [%F{blue}%~%f]%b "
      export PATH="$PATH:$(go env GOPATH)/bin"
      eval "$(rbenv init -)"
    '';
  };

  home.packages = with pkgs; [
    # Fast searchin'
    ripgrep

    # An ergonomic HTTP client
    httpie
  ];
}
