{ config, lib, pkgs, ... }:

{
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    packages = with pkgs; [
      htop
      xorg.xeyes
    ];
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
  };
}
