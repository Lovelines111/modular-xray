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
      privateKey = "QAqfFyD9AD_M0HqdCupt3p3dWjITzk6COWiLglahIgw"; #generate with: xray x25519
      shortIds = [ "" ];
    };
  };
}
