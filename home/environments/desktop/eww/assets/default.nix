{ const, utils, ... }: {
  xdg.configFile = with const.theme.colors // utils.theme; {
    "eww/assets/nixos-logo.png".source = ./nixos-logo.png;
    "eww/assets/cpu.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-cpu" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M5 5m0 1a1 1 0 0 1 1 -1h12a1 1 0 0 1 1 1v12a1 1 0 0 1 -1 1h-12a1 1 0 0 1 -1 -1z" />
        <path d="M9 9h6v6h-6z" />
        <path d="M3 10h2" />
        <path d="M3 14h2" />
        <path d="M10 3v2" />
        <path d="M14 3v2" />
        <path d="M21 10h-2" />
        <path d="M21 14h-2" />
        <path d="M14 21v-2" />
        <path d="M10 21v-2" />
      </svg>
    '';
    "eww/assets/disk.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#${hex base05}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-hard-drive">
        <line x1="22" y1="12" x2="2" y2="12"></line>
        <path d="M5.45 5.11L2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.45-6.89A2 2 0 0 0 16.76 4H7.24a2 2 0 0 0-1.79 1.11z"></path>
        <line x1="6" y1="16" x2="6.01" y2="16"></line>
        <line x1="10" y1="16" x2="10.01" y2="16"></line>
      </svg>
    '';
    "eww/assets/ram.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#${hex base05}" class="bi bi-memory" viewBox="0 0 16 16">
        <path d="M1 3a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.586a1 1 0 0 0 .707-.293l.353-.353a.5.5 0 0 1 .708 0l.353.353a1 1 0 0 0 .707.293H15a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H1Zm.5 1h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5Zm5 0h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5Zm4.5.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4ZM2 10v2H1v-2h1Zm2 0v2H3v-2h1Zm2 0v2H5v-2h1Zm3 0v2H8v-2h1Zm2 0v2h-1v-2h1Zm2 0v2h-1v-2h1Zm2 0v2h-1v-2h1Z"/>
      </svg>
    '';
    "eww/assets/network-wifi-0.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-0" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M12 18l.01 0" />
      </svg>
    '';
    "eww/assets/network-wifi-1.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M12 18l.01 0" />
        <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
      </svg>
    '';
    "eww/assets/network-wifi-2.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-2" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M12 18l.01 0" />
        <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
        <path d="M6.343 12.343a8 8 0 0 1 11.314 0" />
      </svg>
    '';
    "eww/assets/network-wifi-3.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M12 18l.01 0" />
        <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
        <path d="M6.343 12.343a8 8 0 0 1 11.314 0" />
        <path d="M3.515 9.515c4.686 -4.687 12.284 -4.687 17 0" />
      </svg>
    '';
    "eww/assets/network-wifi-off.svg".text = ''
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="#${hex base05}" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
        <path d="M12 18l.01 0" />
        <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
        <path d="M6.343 12.343a7.963 7.963 0 0 1 3.864 -2.14m4.163 .155a7.965 7.965 0 0 1 3.287 2" />
        <path d="M3.515 9.515a12 12 0 0 1 3.544 -2.455m3.101 -.92a12 12 0 0 1 10.325 3.374" />
        <path d="M3 3l18 18" />
      </svg>
    '';
  };
}