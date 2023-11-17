{ pkgs, nurpkgs, const, utils, ... }: {
  programs.firefox = {
    enable = true;
    profiles.${const.user.name} = with const.theme.colors // utils.theme; {
      search = {
        default = "Google";
        engines = {
          "Google" = {
            definedAliases = [ "@google" ];
            urls = [{
              template = "https://www.google.com/";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
          };
          "Youtube" = {
            definedAliases = [ "@youtube" "@yt" ];
            urls = [{
              template = "https://www.youtube.com/results";
              params = [{ name = "search_query"; value = "{searchTerms}"; }];
            }];
          };
          "NPM" = {
            definedAliases = [ "@npm" ];
            urls = [{
              template = "https://www.npmjs.com/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
          };
          "MDN" = {
            definedAliases = [ "@mdn" ];
            urls = [{
              template = "https://developer.mozilla.org/en-US/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
          };
          "Cargo" = {
            definedAliases = [ "@cargo" "@crates" ];
            urls = [{
              template = "https://crates.io/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
          };
          "Rust Docs" = {
            definedAliases = [ "@rsdoc" ];
            urls = [{
              template = "https://crates.io/search";
              params = [{ name = "query"; value = "{searchTerms}"; }];
            }];
          };
          "My NixOS" = {
            definedAliases = [ "@nix" ];
            urls = [{
              template = "https://mynixos.com/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
          };
        };
      };
      extensions = with nurpkgs.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        react-devtools
      ];
      settings = {
        "browser.newtabpage.pinned" = [
          { url = "https://www.youtube.com/"; label = "YouTube"; }
          { url = "https://github.com/"; label = "GitHub"; }
          { url = "https://www.netflix.com/browse"; label = "Netflix"; }
          { url = "https://www.discogs.com/"; label = "Discogs"; }
        ];
        "browser.uiCustomization.state" = {
          placements = {
            widget-overflow-fixed-list = [];
            unified-extensions-area = [];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "urlbar-container"
              "customizableui-special-spring2"
              "privatebrowsing-button"
              "fullscreen-button"
              "logins-button"
              "downloads-button"
              "unified-extensions-button"
              "history-panelmenu"
              "preferences-button"
              "fxa-toolbar-menu-button"
            ];
            toolbar-menubar= [ "menubar-items" ];
            TabsToolbar= [
              "firefox-view-button"
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
            PersonalToolbar =[];
          };
          seen = [
            "save-to-pocket-button"
            "developer-button"
            "sponsorblocker_ajay_app-browser-action"
            "ublock0_raymondhill_net-browser-action"
            "_react-devtools-browser-action"
          ];
        };
        "privacy.trackingprotection.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "devtools.screenshot.audio.enabled" = false;
        "devtools.command-button-frames.enabled" = false;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
        "devtools.chrome.enabled" = true;
      };
      userChrome = ''
        #TabsToolbar {
          background: #${hex base00} !important;
        }

        .tab-background:is([selected], [multiselected]) {
          background: #${hex base01} !important;
        }

        #urlbar-background {
          background: #${hex base00} !important;
        }

        .browser-toolbar:not(.titlebar-color) {
          background: #${hex base01} !important;
        }

        #tabbrowser-tabpanels {
          background: #${hex base00} !important;
        }
      '';
      userContent = ''
        :root {
          scrollbar-color: #${hex base04} #${hex base01} !important;
        }

        * {
          scrollbar-width: thin;
        }

        @-moz-document
        url("about:home"),
        url("about:blank"),
        url("about:newtab"),
        url("about:privatebrowsing") {
          body {
            background: #${hex base00} !important;
          }

          .search-handoff-button {
            background: #${hex base01} !important;
          }

          .top-site-outer:is(.active, :focus, :hover) {
            background: #${hex base02} !important;
          }

          .top-site-button > .tile {
            background: #${hex base01} !important;
          }

          .top-site-icon {
            background-color: #${hex base01} !important;
          }

          context-menu-button {
            fill: #${hex base04} !important;
          }

          .context-menu-button:is(:active, :focus) {
            fill: #${hex base0D} !important;
          }
        }
      '';
    };
  };
}