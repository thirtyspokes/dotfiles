{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fira-code
  ];
}
