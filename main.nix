{ pkgs, ... }:
{
  services.xray = {
    enable = true;
    # settingsFile = ./versions/YEDA.json;
    # settingsFile = ./versions/yeda1.json;
    settingsFile = ./xray/versions/gen1.json;
  };
}
