{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  ####################
  ## Shell
  ####################
  # XFCE handles the desktop shell — this is just your terminal shell.
  # dash matches your minimal-tooling preference; if you actually want
  # interactive niceties (history search, completion) day-to-day, bash or
  # zsh is more comfortable as a login shell even if scripts stay dash-clean.

  home.sessionVariables = {
    EDITOR = "vim";
  };

  ####################
  ## Git
  ####################

  programs.git = {
    enable = true;
    # fill in:
    # userName = "";
    # userEmail = "";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  ####################
  ## User-level packages
  ####################
  # System-wide tools live in configuration.nix; put anything personal /
  # user-scoped here instead (keeps the system config lean and this file as
  # the "your stuff" layer).

  home.packages = with pkgs; [
    ripgrep
    fd
    tree
  ];

  ####################
  ## XFCE tweaks (optional, safe to leave empty at first)
  ####################
  # Home-manager can manage some XFCE settings (panel layout, keybinds, etc.)
  # via xfconf, but it's fiddly to get right blind. Recommend leaving this
  # section empty for the first boot, configuring XFCE by hand through its
  # own settings GUI once it's running, and only codifying it here later
  # once you know exactly what you want to keep.
}
