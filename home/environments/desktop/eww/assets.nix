{ const, usrLib, ... }: {
  home.file = let
    dir = ".config/eww/assets";
  in with const.theme.color // usrLib.color; {
    ewwNixIcon = {
      target = "${dir}/nix-logo.svg";
      text = ''
        <svg width="26" height="24" viewBox="0 0 24.375 22.5" xmlns="http://www.w3.org/2000/svg">
          <path style="fill:${hex accent.light};" d="m142.498-950.564-5.482 9.493-1.28-2.17 1.478-2.542-2.934-.008-.625-1.084.638-1.109 4.176.014 1.501-2.588zM142.918-942.976h10.961l-1.238 2.194-2.94-.008 1.46 2.544-.627 1.084h-1.279l-2.077-3.622-2.99-.006zM149.298-947.135l-5.48-9.493 2.518-.024 1.463 2.55 1.474-2.536h1.251l.641 1.108-2.1 3.61 1.49 2.593z" transform="translate(-132.717 958.144)"/>
          <path style="fill:${hex accent.dark};" d="m140.52-946.654 5.48 9.493-2.519.024-1.463-2.55-1.473 2.536h-1.252l-.64-1.107 2.099-3.61-1.49-2.593zM146.885-950.837h-10.962l1.24-2.193 2.94.008-1.46-2.545.625-1.083 1.28-.001 2.076 3.623 2.991.006zM147.312-943.227l5.482-9.492 1.28 2.169-1.478 2.542 2.934.008.625 1.084-.638 1.109-4.176-.013-1.501 2.587z" transform="translate(-132.717 958.144)"/>
        </svg>
      ''; 
    };
    ewwCpuIcon = {
      target = "${dir}/cpu.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-cpu" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
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
    };
    ewwDiskIcon = {
      target = "${dir}/disk.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24.375 22.5" fill="none" stroke="${hex (builtins.elemAt fg 2)}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-hard-drive">
          <line x1="22" y1="12" x2="2" y2="12"></line>
          <path d="M5.45 5.11L2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.45-6.89A2 2 0 0 0 16.76 4H7.24a2 2 0 0 0-1.79 1.11z"></path>
          <line x1="6" y1="16" x2="6.01" y2="16"></line>
          <line x1="10" y1="16" x2="10.01" y2="16"></line>
        </svg>
      '';
    };
    ewwRamIcon = {
      target = "${dir}/ram.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="${hex (builtins.elemAt fg 2)}" class="bi bi-memory" viewBox="0 0 16 16">
          <path d="M1 3a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.586a1 1 0 0 0 .707-.293l.353-.353a.5.5 0 0 1 .708 0l.353.353a1 1 0 0 0 .707.293H15a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H1Zm.5 1h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5Zm5 0h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5Zm4.5.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-4ZM2 10v2H1v-2h1Zm2 0v2H3v-2h1Zm2 0v2H5v-2h1Zm3 0v2H8v-2h1Zm2 0v2h-1v-2h1Zm2 0v2h-1v-2h1Zm2 0v2h-1v-2h1Z"/>
        </svg>
      '';
    };
    ewwWifi0Icon = {
      target = "${dir}/network-wifi-0.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-0" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
          <path d="M12 18l.01 0" />
        </svg>
      '';
    };
    ewwWifi1Icon = {
      target = "${dir}/network-wifi-1.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
          <path d="M12 18l.01 0" />
          <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
        </svg>
      '';
    };
    ewwWifi2Icon = {
      target = "${dir}/network-wifi-2.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-2" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
          <path d="M12 18l.01 0" />
          <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
          <path d="M6.343 12.343a8 8 0 0 1 11.314 0" />
        </svg>
      '';
    };
    ewwWifi3Icon = {
      target = "${dir}/network-wifi-3.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
          <path d="M12 18l.01 0" />
          <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
          <path d="M6.343 12.343a8 8 0 0 1 11.314 0" />
          <path d="M3.515 9.515c4.686 -4.687 12.284 -4.687 17 0" />
        </svg>
      '';
    };
    ewwWifiOffIcon = {
      target = "${dir}/network-wifi-off.svg";
      text = ''
        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-wifi-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="${hex (builtins.elemAt fg 2)}" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
          <path d="M12 18l.01 0" />
          <path d="M9.172 15.172a4 4 0 0 1 5.656 0" />
          <path d="M6.343 12.343a7.963 7.963 0 0 1 3.864 -2.14m4.163 .155a7.965 7.965 0 0 1 3.287 2" />
          <path d="M3.515 9.515a12 12 0 0 1 3.544 -2.455m3.101 -.92a12 12 0 0 1 10.325 3.374" />
          <path d="M3 3l18 18" />
        </svg>
      '';
    };
  };
}