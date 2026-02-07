{ pkgs, lib, config, ... }:
let cfg = config.modules.floorp;
in {
  options.modules.floorp = {
    enable = lib.mkEnableOption "floorp";

    autostart = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.floorp = {
      enable = true;
      languagePacks = [ "en-US" ];

      policies = {
        AppAutoUpdate = false;
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = true;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "never";
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = true;
        EncryptedMediaExtensions.Enabled = true;
        ExtensionUpdate = false;
        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          Stories = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Snippets = false;
          Locked = true;
        };
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
        };
        GenerativeAI = {
          Enabled = false;
          Chatbot = false;
          LinkPreviews = false;
          TabGroups = false;
          Locked = true;
        };
        NetworkPrediction = false;
        OfferToSaveLogins = false;
        OverrideFirstRunPage = "about:newtab";
        OverridePostUpdatePage = "about:newtab";
        PasswordManagerEnabled = false;
        PromptForDownloadLocation = false;
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
        SkipTermsOfUse = false;
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };
      };

      profiles.${config.home.username} = {
        search = {
          force = true;
          default = "google";
          engines = {
            "Google" = {
              definedAliases = [ "@google" ];
              urls = [{
                template = "https://www.google.com/search";
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
            "Wikipedia" = {
              definedAliases = [ "@wikipedia" "@wiki" ];
              urls = [{
                template = "https://en.wikipedia.org/wiki/Special:Search";
                params = [{
                  name = "search";
                  value = "{searchTerms}";
                }];
              }];
            };
            "Dictionary" = {
              definedAliases = [ "@dictionary" "@define" ];
              urls = [{
                template =
                  "https://www.merriam-webster.com/dictionary/{searchTerms}";
              }];
            };
            "Thesaurus" = {
              definedAliases = [ "@thesaurus" "@simile" "@antonym" ];
              urls = [{
                template =
                  "https://www.merriam-webster.com/thesaurus/{searchTerms}";
              }];
            };
            "Etymonline" = {
              definedAliases = [ "@etymonline" "@etym" ];
              urls = [{
                template = "https://www.etymonline.com/search";
                params = [{
                  name = "q";
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
          };
        };

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            proton-pass
            ublock-origin
            darkreader
            dearrow
            sponsorblock
            user-agent-string-switcher
            react-devtools
            copy-selection-as-markdown

            # get addonId from about:debugging#/runtime/this-firefox
            # get url from add to firefox button
            # get mozPermissions from projects manifest file

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

            (buildFirefoxXpiAddon {
              pname = "Hide Youtube Shorts";
              version = "1.8.5";
              addonId = "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}";
              url =
                "https://addons.mozilla.org/firefox/downloads/file/4563088/hide_youtube_shorts-1.8.5.xpi";
              sha256 = "2TdWDSFCy1P3rYPBHXdiCQZ8AyLRFORqc/rbSyU8NKc=";
              meta = with pkgs.lib; {
                license = licenses.gpl3Only;
                mozPermissions = [ "storage" ];
                platforms = platforms.all;
              };
            })
          ];
        };

        settings = {
          "browser.uiCustomization.state" = {
            placements = {
              widget-overflow-fixed-list = [ ];
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
            };
            TabsToolbar = [
              "tabbrowser-tabs"
              "new-tab-button"
            ];
          };

          "extensions.autoDisableScopes" = 0;
          "extensions.activeThemeID" = "{995463c6-18a1-4cf7-b0f1-564e050d778b}";
          "browser.theme.toolbar-theme" = 0;

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

          "widget.use-xdg-desktop-portal.file-picker" = true;
        };

        userChrome = ''
          .titlebar-close {
            display:none !important;
          }
        '';
      };
    };
  };
}
