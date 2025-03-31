**Xray-Nix Modular Configuration**

This is a POC. It contains an example of a modular Xray (V2Ray) configuration done wit Nix and replicating it's famous generational approach.
Regular Nix generations allow to backtrack xray configurations as well, but this requires reboot and thus time, plus those will be mixed with other generations.
I wanted to make generations for xray config separate, while also making it easier to maintain the configuration using modules. Plus I wanted to test whether or not my approach was possibly doable.
The idea here is to create a .nix file that will call other default files from the respective orders, then we do `nix eval` on it and convert the entire thing into Json config that we then use in `services.xray.settingsFile` or `xray -c` if you're on other distro.

I left a sctipt called build.sh in the main directory that will create a new json file in ./xray/versions
The file structure can be anything really since we're using modules. I came up with this:
```
xray
    ├── default.nix
    ├── inbounds
    │   ├── default.nix
    │   ├── ssid.nix
    │   └── vless.nix
    ├── outbounds
    │   └── default.nix
    ├── users
    │   ├── default.nix
    │   ├── user1.nix
    │   └── user2.nix
    └── versions
        └── gen1.json
```

The file that becomes json in the end looks like this:

```
{
  log = {
    loglevel = "warning";
  };

  inbounds = import ./inbounds/default.nix;
  outbounds = import ./outbounds/default.nix;

}
```



And turns into this after we run ./build.sh:

```
[oli@nixos:~/modular-xray]$ cat xray/versions/gen1.json
{"inbounds":[{"port":443,"protocol":"vless","settings":{"clients":[{"flow":"xtls-rprx-vision","id":"9284305e-9231-4904-8a94-389b00b47040"},{"flow":"xtls-rprx-vision","id":"8da8da8d-61f8-467b-a92e-e75ffff49020"}],"decryption":"none","fallbacks":[]},"streamSettings":{"network":"tcp","realitySettings":{"dest":"www.cloudflare.com:443","privateKey":"QAqfFyD9AD_M0HhdCupt3p6dWjITzl6CvWiLglahIgw","serverNames":["www.cloudflare.com"],"shortIds":[""],"show":false,"xver":0},"security":"reality"}},{"port":10808,"protocol":"vless","settings":{"clients":[{"flow":"xtls-rprx-vision","id":"9284305e-9231-4904-8a94-389b00b47040"},{"flow":"xtls-rprx-vision","id":"8da8da8d-61f8-467b-a92e-e75ffff49020"}],"decryption":"none","fallbacks":[]},"streamSettings":{"network":"tcp","realitySettings":{"dest":"www.bal.com:443","privateKey":"QAqfFyD9AD_M0HhdCupt3p6dWjITzl6CvWiLglahIgw","serverNames":["www.bal.com"],"shortIds":[""],"show":false,"xver":0},"security":"reality"}}],"log":{"loglevel":"warning"},"outbounds":[{"protocol":"freedom"}],"users":[{"flow":"xtls-rprx-vision","id":"9284305e-9231-4904-8a94-389b00b47040"},{"flow":"xtls-rprx-vision","id":"8da8da8d-61f8-467b-a92e-e75ffff49020"}]}
```


Users must be called within the inbounds files. it can be done like so:

```
let
  users = import ../users; #call xray/users/default.nix as a variable   <------
in
{
  port = 443;
  protocol = "vless";
  settings = {
    clients = users;     #call users variable.   <------
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
      privateKey = "QAqfFyD9AD_M0HhdCupt3p6dWjITzl6CvWiLglahIgw";
      shortIds = [ "" ];
    };
  };
}
```
