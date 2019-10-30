{
  networking.wireguard.enable = true;

  #networking.wireguard.interfaces = {
  #  "hex.tq.rs" = {
  #    ips = [ "10.10.10.4/32" "fc00:23:6::4/128" ];
  #    dns = [ "10.10.10.3" ]

  #    generatePrivateKeyFile = false;
  #    privateKeyFile = /etc/wireguard/private_key;

  #    peers = [
  #      {
  #        publicKey = "U2ijs3wSSZYizj3x/K/OCYRc6yExETZUOayMFnGYLgs=";
  #        presharedKeyFile = /etc/wireguard/preshared_key;
  #        allowedIPs = [ "10.10.10.1/24" "192.168.0.0/24" ];
  #        endpoint = "dozer.qt.rs:51820";
  #        persistentKeepAlive = 25;
  #      }
  #    ];
  #  };
  #};
}
