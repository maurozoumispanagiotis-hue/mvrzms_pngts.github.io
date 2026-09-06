{ config, pkgs, lib, ... }:

{
  ####################
  ## Nvidia Optimus (hybrid Intel iGPU + RTX 5060 dGPU)
  ####################
  # This file only gets imported by the "f16" flake output, never "vm-test"
  # — a VM has no real GPU to hand to this config, so importing it there
  # would just fail to build.

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # REQUIRED: fill these in from the real hardware. Find them with:
      #   lspci | grep -E "VGA|3D"
      # e.g. "0000:00:02.0" -> "PCI:0:2:0"
      intelBusId = "PCI:0:2:0";   # placeholder — fix this
      nvidiaBusId = "PCI:1:0:0";  # placeholder — fix this
    };

    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.steam-hardware.enable = true;
  # Remember: nvidia-offload steam
}
