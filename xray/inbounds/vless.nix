let
  users = import ../users;
in
{
  port = 443;
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
      dest = "www.cloudflare.com:443";
      xver = 0;
      serverNames = [ "www.cloudflare.com" ];
      privateKey = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"; #generate with: xray x25519
      shortIds = [ "" ];
    };
  };
}
