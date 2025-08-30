{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.irc;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.senpai pkgs.teams-for-linux];

    custom.persist = {
      home.directories = [
        ".config/senpai"
      ];
    };
  };
}
