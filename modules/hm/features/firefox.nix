{ pkgs, repos, config, usrLib, ... }: {
  home.sessionVariables.BROWSER = "firefox";

  programs.firefox = {
    enable = true;
    profiles.${config.home.username} =
      with config.theme.color // usrLib.color; {
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
        extensions = with repos.nurpkgs.repos.rycee.firefox-addons; [
          ublock-origin
          sponsorblock
          react-devtools
          darkreader
          dearrow
          copy-selection-as-markdown
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
              PersonalToolbar = [ ];
            };
            seen = [
              "save-to-pocket-button"
              "developer-button"
              "sponsorblocker_ajay_app-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_react-devtools-browser-action"
              "youtubeskipad_010pixel_com-browser-action"
              "addon_darkreader_org-browser-action"
              "adguardadblocker_adguard_com-browser-action"
              "password_generator_kolya_ca-browser-action"
              "dearrow_ajay_app-browser-action"
            ];
          };
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
        userChrome = ''
          :root {
            --color-white: ${hex white.default} !important;
            --color-blue-05: ${hex blue.light} !important;
            --color-blue-30: ${hex blue.light} !important;
            --color-blue-50: ${hex blue.default} !important;
            --color-blue-60: ${hex blue.default} !important;
            --color-blue-70: ${hex blue.dark} !important;
            --color-blue-80: ${hex blue.dark} !important;
            --color-cyan-20: ${hex cyan.light} !important;
            --color-cyan-30: ${hex cyan.default} !important;
            --color-cyan-50: ${hex cyan.dark} !important;
            --color-gray-05: ${hex gray.light} !important;
            --color-gray-50: ${hex gray.light} !important;
            --color-gray-60: ${hex gray.default} !important;
            --color-gray-70: ${hex gray.default} !important;
            --color-gray-90: ${hex gray.dark} !important;
            --color-gray-100: ${hex gray.dark} !important;
            --color-green-05: ${hex green.light} !important;
            --color-green-30: ${hex green.light} !important;
            --color-green-50: hex ${hex green.default} !important;
            --color-green-80: hex ${hex green.dark} !important;
            --color-red-05: ${hex red.light} !important;
            --color-red-30: ${hex red.light} !important;
            --color-red-50: ${hex red.default} !important;
            --color-red-80: ${hex red.dark} !important;
            --color-yellow-05: ${hex yellow.light} !important;
            --color-yellow-30: ${hex yellow.light} !important;
            --color-yellow-50: ${hex yellow.default} !important;
            --color-yellow-80: ${hex yellow.dark} !important;
            --border-radius-circle: ${
              toString config.theme.radius.full
            }px !important;
            --border-radius-small: ${
              toString config.theme.radius.sm
            }px !important;
            --border-width: 1px !important;
            --font-weight-bold: 700 !important;

            --cfr-active-color: ${hex accent.default} !important;

            --tabpanel-background-color: ${
              hex (builtins.elemAt bg 0)
            } !important;

            --platform-color-accent: var(--button-primary-bgcolor, AccentColor);
            --platform-color-accent-hover: var(--button-primary-hover-bgcolor);
            --platform-color-accent-active: var(--button-primary-active-bgcolor);
            --link-color: ${hex accent.default};
            --link-color-hover: ${hex accent.light};
            --link-color-active: ${hex accent.dark};
            --link-color-visited: ${hex purple.default};
            --text-color: ${hex (builtins.elemAt fg 0)};

            #TabsToolbar {
              background: ${hex (builtins.elemAt bg 0)} !important;
            }

            .tab-background:is([selected], [multiselected]) {
              background: ${hex (builtins.elemAt bg 1)} !important;
            }

            #urlbar-background {
              background: ${hex (builtins.elemAt bg 0)} !important;
            }

            .browser-toolbar:not(.titlebar-color) {
              background: ${hex (builtins.elemAt bg 1)} !important;
            }

            #tabbrowser-tabpanels {
              background: ${hex (builtins.elemAt bg 0)} !important;
            }
          }
        '';
        userContent = ''
          @-moz-document
          url("about:home"),
          url("about:blank"),
          url("about:newtab"),
          url("about:privatebrowsing") {
            :root {
              --newtab-background-color: ${
                hex (builtins.elemAt bg 0)
              } !important;
              --newtab-background-color-secondary: ${
                hex (builtins.elemAt bg 1)
              } !important;
              --newtab-text-primary-color: ${
                hex (builtins.elemAt fg 0)
              } !important;
              --newtab-primary-action-background: ${
                hex accent.default
              } !important;
              --newtab-primary-element-text-color: ${
                hex (builtins.elemAt fg 0)
              } !important;
              --newtab-wordmark-color: ${hex (builtins.elemAt fg 1)} !important;
              --newtab-status-success: ${hex green.default} !important;
              --newtab-status-error: ${hex red.default} !important;
              --newtab-text-emphasis-background: ${
                hex accent.default
              } !important;
              --newtab-text-emphasis-text-color: ${
                hex (builtins.elemAt fg 0)
              } !important;
            }
          }

          /* :root {
            scrollbar-width: thin; !important
            scrollbar-color: ${hex gray.default} ${
              hex (builtins.elemAt bg 1)
            } !important;
          } */

          ::selection,
          ::-moz-selection {
            background: ${hexA accent.default 0.6} !important;
          }

          /*
          a, a * {
            color: ${hex accent.default} !important;
            fill: ${hex accent.default} !important;
          }
          */
        '';
      };
  };
}
