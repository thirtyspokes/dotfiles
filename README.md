dotfiles
========
Install [Nix](https://nixos.org/download.html) and [home-manager](https://rycee.gitlab.io/home-manager/).

Then, add the wanted modules to `home.nix`:

```nix
{ config, pkgs, ... }:

let
  dotfiles = "<wherever you cloned this>";
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ray";
  home.homeDirectory = "/Users/ray";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  imports = [
    "${dotfiles}/basics.nix"
    "${dotfiles}/tmux.nix"
    "${dotfiles}/neovim.nix"
  ];
}
```

Then, `home-manager switch` (and probably restart iterm2).
