{ pkgs, config, ... }: {
  home.sessionVariables.BROWSER =
    "${config.programs.firefox.package}/bin/firefox";
  home.file.".mozilla/native-messaging-hosts/com.github.browserpass.native.json".source =
    "${pkgs.browserpass}/lib/mozilla/native-messaging-hosts/com.github.browserpass.native.json";

  programs.firefox = {
    enable = true;
    # package = pkgs.rosetta.firefox-bin;
    profiles.${config.home.username} = {
      search = {
        force = true;
        default = "Google";
        engines = {
          "Google" = {
            definedAliases = [ "@google" ];
            urls = [{
              template = "https://www.google.com/";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
          "Youtube" = {
            definedAliases = [ "@youtube" "@yt" ];
            urls = [{
              template = "https://www.youtube.com/results";
              params = [{
                name = "search_query";
                value = "{searchTerms}";
              }];
            }];
          };
          "GitHub" = {
            definedAliases = [ "@github" "@gh" ];
            urls = [{
              template = "https://github.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
          "NPM" = {
            definedAliases = [ "@npm" ];
            urls = [{
              template = "https://www.npmjs.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
          "MDN" = {
            definedAliases = [ "@mdn" ];
            urls = [{
              template = "https://developer.mozilla.org/en-US/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
          "Cargo" = {
            definedAliases = [ "@cargo" "@crates" ];
            urls = [{
              template = "https://crates.io/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
          };
          "Rust Docs" = {
            definedAliases = [ "@rs" ];
            urls = [{
              template = "https://docs.rs/releases/search";
              params = [{
                name = "query";
                value = "{searchTerms}";
              }];
            }];
          };
          "Nix Pkgs" = {
            definedAliases = [ "@nixpkgs" ];
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "nixpkgs+{searchTerms}";
              }];
            }];
          };
          "Nix Pkgs Bin" = {
            definedAliases = "@nixbin";
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "bin+{searchTerms}";
              }];
            }];
          };
          "Nix Lib" = {
            definedAliases = [ "@nixlib" ];
            urls = [{
              template = "https://noogle.dev/q";
              params = [{
                name = "q";
                term = "{searchTerms}";
              }];
            }];
          };
          "NixOS Opts" = {
            definedAliases = [ "@nixos" ];
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "nixpkgs%2Foption+{searchTerms}";
              }];
            }];
          };
          "HM Opts" = {
            definedAliases = [ "@hm" ];
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "home-manager+{searchTerms}";
              }];
            }];
          };
          "NixVim Opts" = {
            definedAliases = [ "@nixvim" ];
            urls = [{
              template = "https://nix-community.github.io/nixvim";
              params = [{
                name = "search";
                value = "{searchTerms}";
              }];
            }];
          };
          "Dictionary" = {
            definedAliases = [ "@dictionary" "@define" ];
            urls = [{
              template = "https://www.dictionary.com/browse/{searchTerms}";
            }];
          };
          "Thesaurus" = {
            definedAliases = [ "@thesaurus" "@simile" "@antonym" ];
            urls = [{
              template = "https://www.thesaurus.com/browse/{searchTerms}";
            }];
          };
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        sponsorblock
        react-devtools
        darkreader
        dearrow
        copy-selection-as-markdown
        (buildFirefoxXpiAddon {
          pname = "Tokyonight";
          version = "1.4";
          addonId = "{995463c6-18a1-4cf7-b0f1-564e050d778b}";
          url =
            "https://addons.mozilla.org/firefox/downloads/file/3785565/tokyonight_vim-1.4.xpi";
          sha256 = "uvnU67mWuPWmGxe8EayxrCxu38QJv2oCfr8OprAtjkc=";
          meta = with pkgs.lib; {
            license = licenses.mpl20;
            mozPermissions = [ "theme" ];
            platforms = platforms.all;
          };
        })
      ];
      settings = {
        "browser.newtabpage.pinned" = [
          {
            url = "https://www.youtube.com/";
            label = "YouTube";
          }
          {
            url = "https://github.com/";
            label = "GitHub";
          }
          {
            url = "https://www.netflix.com/browse";
            label = "Netflix";
          }
          {
            url = "https://www.discogs.com/";
            label = "Discogs";
          }
        ];
        "browser.uiCustomization.state" = {
          placements = {
            widget-overflow-fixed-list = [ ];
            unified-extensions-area = [
              "dearrow_ajay_app-browser-action"
              "youtubeskipad_010pixel_com-browser-action"
              "addon_darkreader_org-browser-action"
              "adguardadblocker_adguard_com-browser-action"
              "password_generator_kolya_ca-browser-action"
              "sponsorblocker_ajay_app-browser-action"
            ];
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
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [
              "firefox-view-button"
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
          };
        };
        "extensions.autoDisableScopes" = 0;
        "extensions.activeThemeID" = "{995463c6-18a1-4cf7-b0f1-564e050d778b}";
        "browser.theme.toolbar-theme" = 0;

        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "extensions.pocket.enabled" = false;
        "devtools.screenshot.audio.enabled" = false;
        "devtools.command-button-frames.enabled" = false;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-rulers.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
        "devtools.chrome.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
