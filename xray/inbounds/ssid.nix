let
  users = import ../users;
in
{
  port = 10808;
  protocol = "vless";
  settings = {
    clients = users;
    decryption = "none";
    fallbacks = [];
  };
  streamSettings = {
    network = "tcp";
    security = "reality";
    realitySettings = {
      show = false;
      dest = "www.bal.com:443";
      xver = 0;
      serverNames = [ "www.bal.com" ];
      privateKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"; # generate with: xray x25519
      shortIds = [ "" ];
    };
  };
}
