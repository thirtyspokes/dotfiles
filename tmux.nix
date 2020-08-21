{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
      # A utility that lets native copy/paste
      # work within tmux on MacOS.
      reattach-to-user-namespace
  ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 0;

    extraConfig = ''
      set-option -g prefix C-a
      unbind-key C-a

      set -g mouse on
      set-option -g default-terminal screen-256color

      bind-key : command-prompt
      bind-key r refresh-client
      bind-key L clear-history

      bind-key space next-window
      bind-key bspace previous-window
      bind-key enter next-layout

      bind-key v split-window -h -c "#{pane_current_path}"
      bind-key s split-window -v -c "#{pane_current_path}"
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key C-o rotate-window

      bind-key + select-layout main-horizontal
      bind-key = select-layout main-vertical
      set-window-option -g other-pane-height 25
      set-window-option -g other-pane-width 80

      bind-key a last-pane
      bind-key q display-panes
      bind-key c new-window
      bind-key t next-window
      bind-key T previous-window

      bind-key [ copy-mode

      run-shell "tmux setenv -g TMUX_VERSION $(tmux -V | cut -c 6-)"

      set-option -g default-command "reattach-to-user-namespace -l zsh"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"
      unbind -T copy-mode-vi Enter
      bind-key -T copy-mode-vi Enter send-keys -X copy-pipe "reattach-to-user-namespace pbcopy"
      bind ] run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"

      bind-key -T root WheelUpPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
      bind-key -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
      set-option -g assume-paste-time 0

      set-option -g status-bg colour14
      set-option -g status-left ""
      set-option -g status-right "%d %b %Y | %l:%M %p "
    '';
  };
}
