{
  log = {
    loglevel = "warning";
  };

  users = import ./users/default.nix;

  inbounds = import ./inbounds/default.nix;
  outbounds = import ./outbounds/default.nix;
  
}
