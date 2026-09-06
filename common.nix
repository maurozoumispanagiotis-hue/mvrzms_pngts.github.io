{ config, pkgs, lib, ... }:

{
  ####################
  ## Boot
  ####################

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Harmless in the VM (no Windows to find, so this just does nothing there);
  # on the real laptop it's the line that makes dual-boot work automatically.
  boot.loader.systemd-boot.windows.enable = lib.mkDefault true;

  ####################
  ## Networking
  ####################

  networking.networkmanager.enable = true;

  ####################
  ## Desktop environment
  ####################

  services.xserver.enable = true;
  services.xserver.displayManager.ly.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  ####################
  ## Gaming
  ####################
  # Harmless to enable in the VM too — Steam just won't have real GPU accel
  # there, which is fine, you're not testing gaming performance in the VM.

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };

  ####################
  ## Virtualisation (Kali VM)
  ####################
  # Yes, this means nested virtualisation if you're testing this config
  # inside a VM already — VirtualBox supports nesting, just make sure it's
  # turned on in the VM's settings (Settings > System > Enable Nested
  # VT-x/AMD-V) or libvirtd won't start correctly inside the test VM.

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      ovmf.enable = true;
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;

  ####################
  ## doas instead of sudo
  ####################

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      groups = [ "wheel" ];
      keepEnv = true;
      persist = true;
    }
  ];

  ####################
  ## Users
  ####################

  users.users.negrozoumh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "video" ];
    shell = pkgs.dash;
  };

  ####################
  ## System packages
  ####################

  environment.systemPackages = with pkgs; [
    git
    gdisk
    dash
    wget
    curl
    htop
    llama-cpp
  ];

  system.stateVersion = "24.11";
}
