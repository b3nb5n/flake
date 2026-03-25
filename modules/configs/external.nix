{ ... }: {
  flake.keys.external = {
    e85064 = rec {
      default = ed25519;
      ed25519 = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAVUV1EadnsG1LWB+j3gumtzhrinnGkEISWZoWjm5KLQ E85064@ML-MW702C9C9R"
      ];
    };

    shade = rec {
      default = ed25519;
      ed25519 = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzUbjohI9EJISVfEZDdRSTPZvym0tpk+8SRdOGdasKj"
      ];
    };

    nail = rec {
      default = ed25519;
      ed25519 = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmaSB90K2ZiD6reD5rSvHUn6OVlcr0zmMrGuoHf0WQd"
      ];
    };
  };
}
