{ ... }: {
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.ben.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPThmVlrQHX1cW5FSKCDW0i90PW/AZVdTYdRW/bzfhap"
  ];
}
