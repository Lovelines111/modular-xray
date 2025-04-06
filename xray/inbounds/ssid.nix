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
      dest = "www.bol.com:443";
      xver = 0;
      serverNames = [ "www.bol.com" ];
      privateKey = "yLt98YyK0RTFaB4Xi-0VClaGGoEleG1Tfk26O0H1y14"; # generate with: xray x25519
      #z9j8y8jTe0Xrrh64d4eXaPuGuP92gCVK9Gel0uazmWY
      shortIds = [ "d1bb61dc9cb79acd" ];
    };
  };
}
