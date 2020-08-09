{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    history.extended = true;

    initExtra = ''
      source ~/.nix-profile/etc/profile.d/nix.sh
      export PROMPT="%B%F{magenta}%n@%m%f [%F{blue}%~%f]%b ⚡  "
    '';
  };

  home.packages = with pkgs; [
    ripgrep
    fira-code
  ];
}
