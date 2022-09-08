{ config, lib, pkgs, ... }:

{
  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    packages = with pkgs; [
      htop
      xorg.xeyes
      ghc
      haskell-language-server
    ];
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bash.enable = true;
    zsh.enable = true;
  };
}
