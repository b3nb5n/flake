{ ... }: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      # PasswordAuthentication = false;
      # KbdInteractiveAuthentication = false;
    };
  };

  # ssh-keygen -t ed25519
  #	cat ~/.ssh/id_ed25519.pub
  users.users.ben.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPg2f5nVxqMPFXaMR1IHcauYFDgkxehA8s0bSZhdp41S ben@bnixdsk"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzUbjohI9EJISVfEZDdRSTPZvym0tpk+8SRdOGdasKj ben@bmacbook"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIWdE1UyMWizlYLRAmTfnuAW+0/ZlTlL/vG2I4NB4q9" # phone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2zDiySlp+GqeqPDYaiNn174oPzguPEZic21N+evG0x" # workbook
  ];
}
