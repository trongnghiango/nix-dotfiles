{
  config,
  pkgs,
  inputs,
  display,
  hostName,
  ...
}:

{
  users.users.ka = {
    isNormalUser = true;
    description = "Ka";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "storage"
    ];
    shell = pkgs.zsh;
  };
}
