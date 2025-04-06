{
    "servers" = [
      "127.0.0.1"  # Redirect DNS queries to local FakeDNS
      "9.9.9.9"  # Fallback DNS server (Cloudflare)
    ];
    "queryStrategy" = "UseIP";
    "disableCache" = false;
    "disableFallback" = false;
    "disableFallbackIfMatch" = true;
}
