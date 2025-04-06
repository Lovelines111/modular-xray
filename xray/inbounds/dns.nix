    {
      "port" = 53;
      "protocol" = "dokodemo-door";
      "settings" = {
        "address" = "127.0.0.1";  # Local address for FakeDNS
        "port" = 53;  # DNS port
        "network" = "udp";  # Ensure UDP is used for DNS
      };
      "tag" = "dns-in";
    }
