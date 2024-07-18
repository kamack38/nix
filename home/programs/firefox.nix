{ pkgs, config }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
    profiles.${config.var.username} = {
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bypass-paywalls-clean
        ublock-origin
        darkreader
        vimium
        no-pdf-download
        languagetool
        steam-database

        # Consents
        consent-o-matic
        istilldontcareaboutcookies

        # YouTube
        enhancer-for-youtube
        return-youtube-dislikes
        sponsorblock
      ];
      search = {
        default = "BraveSearch";
        engines = {
          "BraveSearch" = {
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }
              {
                template =
                  "https://search.brave.com/api/suggest?q={searchTerms}";
                type = "application/x-suggestions+json";
              }
            ];
            icon =
              "https://brave.com/static-assets/images/cropped-brave_appicon_release-32x32.png";
            definedAliases = [ "@brave" ];
          };

          "Youtube" = {
            urls = [{
              template = "https://www.youtube.com/results";
              params = [{
                name = "search_query";
                value = "{searchTerms}";
              }];
            }];
            icon = "https://www.youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@yt" ];
          };
          "GitHub" = {
            urls = [{
              template = "https://github.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = [ "gh" ];
          };
          "Crates" = {
            urls = [{
              template = "https://crates.io/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = [ "@crates" "@cargo" ];
          };

          "Cambridge Dictionary (EN/PL)" = {
            urls = [
              {
                template =
                  "https://dictionary.cambridge.org/search/direct/?datasetsearch=english-polish&q={searchTerms}";
              }
              {
                rels = [ "suggestions" ];
                template =
                  "https://dictionary.cambridge.org/autocomplete/amp?dataset=english-polish&q={searchTerms}";
                type = "application/x-suggestions+json";

              }
            ];
            icon =
              "https://dictionary.cambridge.org/external/images/favicon.ico?version=6.0.27";
            definedAliases = [ "@cmb" ];
          };

          "Arch wiki" = {
            urls = [{
              template = "https://wiki.archlinux.org/index.php";
              params = [{
                name = "search";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = [ "@aw" "@arch-wiki" ];
          };

          "MyNixOS" = {
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            icon =
              "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "nix" ];
          };

          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Wikipedia (en)".metaData.alias = "@wiki";
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };
      settings = {

        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.topSitesRows" = 2;
        "browser.newtabpage.pinned" = ''
          [{"url":"https://www.youtube.com/?gl=PL","label":"YouTube","baseDomain":"youtube.com"},{"url":"https://www.twitch.tv/","label":"Twitch","baseDomain":"twitch.tv"},{"url":"https://steamcommunity.com/id/kamack38/","label":"Steam","baseDomain":"steamcommunity.com"},{"url":"https://twitter.com/home?lang=pl","label":"twitter","baseDomain":"twitter.com"},{"url":"https://google.com","label":"@google","searchTopSite":true,"baseDomain":"google.com"},{"url":"http://127.0.0.1:5500/index.html","label":"127.0.0.1","baseDomain":"127.0.0.1"},{"url":"https://coolors.co/u/kamack38","label":"coolors","baseDomain":"coolors.co"},null,{"url":"https://portal.librus.pl/rodzina/synergia/loguj","label":"portal.librus"},{"url":"https://www.epicgames.com/store/pl/free-games","label":"epicgames","baseDomain":"epicgames.com"},{"url":"https://developer.mozilla.org/pl/docs/Web/HTML","label":"MDN","baseDomain":"developer.mozilla.org"},{"url":"https://steamdb.info/upcoming/free/","label":"steamdb","baseDomain":"steamdb.info"},{"url":"https://github.com/kamack38","label":"github","baseDomain":"github.com"},{"url":"https://kamack38.github.io/","label":"kamack38","baseDomain":"kamack38.github.io"},{"url":"https://www.faceit.com/pl/players/Kamack38","label":"Faceit","baseDomain":"faceit.com"},{"url":"http://178-37-18-4.adsl.inetia.pl/","label":"netiaspot","baseDomain":"178-37-18-4.adsl.inetia.pl"}]'';
        "browser.startup.page" = 3;

        # Don't disable extensions dropped in to a system
        # location, or those owned by the application
        "extensions.autoDisableScopes" = 3;

        # Prevent EULA dialog to popup on first run
        "browser.EULA.override" = true;

        # Increase cache size on disk to 8 GB
        "browser.cache.disk.capacity" = 8192000;
        # force a fixed max cache size on disk
        "browser.cache.disk.smart_size.enabled" = false;
        # lower cache sweep intervals
        "browser.cache.frecency_half_life_hours" = 18;
        # let the browser finish more io on shutdown
        "browser.cache.max_shutdown_io_lag" = 16;
        # fixed maximum 2 GB in memory cache
        "browser.cache.memory.capacity" = 2097152;
        # maximum size of in memory cached objects
        "browser.cache.memory.max_entry_size" = 327680;
        # increase size (in KB) of "Intermediate memory caching of frequently used metadata (a.k.a. disk cache memory pool)"
        "browser.cache.disk.metadata_memory_limit" = 15360;

        # GFX rendering tweaks
        "gfx.canvas.accelerated" = true;
        "gfx.canvas.accelerated.cache-items" = 32768;
        "gfx.canvas.accelerated.cache-size" = 4096;
        "layers.acceleration.force-enabled" = false;
        "gfx.content.skia-font-cache-size" = 80;
        "gfx.webrender.all" = true;
        "gfx.webrender.compositor" = true;
        "gfx.webrender.compositor.force-enabled" = true;
        "gfx.webrender.enabled" = true;
        "gfx.webrender.precache-shaders" = true;
        "gfx.webrender.program-binary-disk" = true;
        "gfx.webrender.software.opengl" = true;
        "image.mem.decode_bytes_at_a_time" = 65536;
        "image.mem.shared.unmap.min_expiration_ms" = 120000;
        "layers.gpu-process.enabled" = true;
        "layers.gpu-process.force-enabled" = true;
        "image.cache.size" = 10485760;
        "media.memory_cache_max_size" = 1048576;
        "media.memory_caches_combined_limit_kb" = 3145728;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;

        # Increase predictive network operations
        "network.dns.disablePrefetchFromHTTPS" = false;
        "network.dnsCacheEntries" = 20000;
        "network.dnsCacheExpiration" = 3600;
        "network.dnsCacheExpirationGracePeriod" = 240;
        "network.predictor.enable-hover-on-ssl" = true;
        "network.predictor.enable-prefetch" = true;
        "network.predictor.preconnect-min-confidence" = 20;
        "network.predictor.prefetch-force-valid-for" = 3600;
        "network.predictor.prefetch-min-confidence" = 30;
        "network.predictor.prefetch-rolling-load-count" = 120;
        "network.predictor.preresolve-min-confidence" = 10;

        # more TLS token caching (fast reconnects)
        "network.ssl_tokens_cache_capacity" = 32768;

        # disable enhanced protection between threads/processes of the browser (which uses LOADS of memory to do)
        "fission.autostart" = false;
        # don't separate the network state (e.g. the cache) by top level domains)
        "privacy.partition.network_state" = false;

        # Reduce the number of processes
        "dom.ipc.processCount" = 1;
        "dom.ipc.processCount.webIsolated" = 1;

        # Disable VPN/mobile promos
        "browser.contentblocking.report.hide_vpn_banner" = true;
        "browser.contentblocking.report.mobile-ios.url" = "";
        "browser.contentblocking.report.mobile-android.url" = "";
        "browser.contentblocking.report.show_mobile_app" = false;
        "browser.contentblocking.report.vpn.enabled" = false;
        "browser.contentblocking.report.vpn.url" = "";
        "browser.contentblocking.report.vpn-promo.url" = "";
        "browser.contentblocking.report.vpn-android.url" = "";
        "browser.contentblocking.report.vpn-ios.url" = "";
        "browser.privatebrowsing.promoEnabled" = false;
      };
      userChrome = # css
        ''
             /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/window_control_placeholder_support.css made available under Mozilla Public License v. 2.0
          See the above repository for updates as well as full license text. */

             /* Creates placeholders for window controls */
             /* This is a supporting file used by other stylesheets */

             /* This stylesheet is pretty much unnecessary if window titlebar is enabled */

             /* This file should preferably be imported before other stylesheets */

             /* Defaults for window controls on RIGHT side of the window */
             /* Modify these values to match your preferences */
             :root:is([tabsintitlebar], [sizemode="fullscreen"]) {
               --uc-window-control-width: 138px;
               /* Space reserved for window controls (Win10) */
               /* Extra space reserved on both sides of the nav-bar to be able to drag the window */
               --uc-window-drag-space-pre: 30px;
               /* left side*/
               --uc-window-drag-space-post: 30px;
               /* right side*/
             }

             :root:is([tabsintitlebar][sizemode="maximized"], [sizemode="fullscreen"]) {
               --uc-window-drag-space-pre: 0px;
               /* Remove pre space */
             }

             @media (-moz-platform: windows-win7),
             (-moz-platform: windows-win8) {
               :root:is([tabsintitlebar], [sizemode="fullscreen"]) {
                 --uc-window-control-width: 105px;
               }
             }

             @media (-moz-gtk-csd-available) {
               :root:is([tabsintitlebar], [sizemode="fullscreen"]) {
                 --uc-window-control-width: 84px;
               }
             }

             @media (-moz-platform: macos) {
               :root:is([tabsintitlebar], [sizemode="fullscreen"]) {
                 --uc-window-control-width: 72px;
               }
             }

             .titlebar-buttonbox,
             #window-controls {
               color: var(--toolbar-color);
             }

             :root[sizemode="fullscreen"] .titlebar-buttonbox-container {
               display: none;
             }

             :root[sizemode="fullscreen"] #navigator-toolbox {
               position: relative;
             }

             :root[sizemode="fullscreen"] #TabsToolbar>.titlebar-buttonbox-container:last-child,
             :root[sizemode="fullscreen"] #window-controls {
               position: absolute;
               display: flex;
               top: 0;
               right: 0;
               height: 40px;
             }

             :root[sizemode="fullscreen"] #TabsToolbar>.titlebar-buttonbox-container:last-child,
             :root[uidensity="compact"][sizemode="fullscreen"] #window-controls {
               height: 32px;
             }

             #nav-bar {
               border-inline: var(--uc-window-drag-space-pre, 0px) solid transparent;
               border-inline-style: solid !important;
               border-right-width: calc(var(--uc-window-control-width, 0px) + var(--uc-window-drag-space-post, 0px));
               background-clip: border-box !important;
             }

             /* Rules for window controls on left layout */
             @media (-moz-bool-pref: "userchrome.force-window-controls-on-left.enabled"),
             (-moz-gtk-csd-reversed-placement),
             (-moz-platform: macos) {
               :root[tabsintitlebar="true"] #nav-bar {
                 border-inline-width: calc(var(--uc-window-control-width, 0px) + var(--uc-window-drag-space-post, 0px)) var(--uc-window-drag-space-pre, 0px);
               }

               :root[sizemode="fullscreen"] #TabsToolbar>.titlebar-buttonbox-container:last-child,
               :root[sizemode="fullscreen"] #window-controls {
                 right: unset;
               }
             }

             @media (-moz-bool-pref: "userchrome.force-window-controls-on-left.enabled") {
               .titlebar-buttonbox-container {
                 order: -1 !important;
               }

               .titlebar-buttonbox {
                 flex-direction: row-reverse;
               }
             }

             /* This pref can be used to force window controls on left even if that is not normal behavior on your OS */
             @supports -moz-bool-pref("userchrome.force-window-controls-on-left.enabled") {
               :root[tabsintitlebar="true"] #nav-bar {
                 border-inline-width: calc(var(--uc-window-control-width, 0px) + var(--uc-window-drag-space-post, 0px)) var(--uc-window-drag-space-pre, 0px);
               }

               :root[sizemode="fullscreen"] #TabsToolbar>.titlebar-buttonbox-container:last-child,
               :root[sizemode="fullscreen"] #window-controls {
                 right: unset;
               }

               .titlebar-buttonbox-container {
                 order: -1 !important;
               }

               .titlebar-buttonbox {
                 flex-direction: row-reverse;
               }
             }

             /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/menulike_bookmarks_folder_popups.css made available under Mozilla Public License v. 2.0
          See the above repository for updates as well as full license text. */

             /* This style makes menus from bookmarks toolbar folders look like context menus do (on Win10) which was the behavior pre-fx92 */

             menupopup[placespopup="true"] {
               padding: 0 !important;
               margin: 0 !important;
               --arrowpanel-background: var(--menu-background-color, Menu) !important;
               border-radius: var(--panel-border-radius) !important;
             }

             .menupopup-arrowscrollbox {
               margin-top: 1px !important;
               border: 1px solid var(--panel-border-color) !important;
               padding: var(--panel-padding) !important;
               border-radius: var(--panel-border-radius) !important;
             }

             :where(menupopup[placespopup="true"]) menu,
             :where(menupopup[placespopup="true"]) menuitem {
               margin-inline: 0 !important;
               padding-inline-start: 1em !important;
               border-radius: 0 !important;
               padding-block: 0.5em !important;
             }

             /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/multi-row_tabs.css made available under Mozilla Public License v. 2.0
          See the above repository for updates as well as full license text. */

             /* Makes tabs to appear on multiple lines
          * Tab reordering will not work and can't be made to work
          * You can use multi-row_tabs_window_control_patch.css to move window controls to nav-bar
          * You might want to move tabs-new-tab-button outside tabs toolbar for smoother behavior */

             /* SETTINGS (you need to create and set these prefs to true in about:config)
          * userchrome.multirowtabs.full-width-tabs.enabled  - make tabs grow horizontally to fill all available space
          * userchrome.multirowtabs.scrollbar-handle.enabled - make scrollbar in tabs box respond to mouse, makes it imposiible to drag window from empty space in tabs box */

             :root {
               --multirow-n-rows: 3;
               /* change maximum number of rows before the rows will start to scroll */
               --multirow-tab-min-width: 100px;
               --multirow-tab-dynamic-width: 1;
               /* Change to 0 for fixed-width tabs using the above width. */
             }

             #tabbrowser-tabs {
               min-height: unset !important;
               padding-inline-start: 0px !important;
             }

             @-moz-document url(chrome://browser/content/browser.xhtml){

               #scrollbutton-up~spacer,
               #scrollbutton-up,
               #scrollbutton-down {
                 display: var(--scrollbutton-display-model, initial);
               }

               scrollbox[part][orient="horizontal"] {
                 display: flex;
                 flex-wrap: wrap;
                 overflow-y: auto;
                 max-height: calc((var(--tab-min-height) + 2 * var(--tab-block-margin, 0px)) * var(--multirow-n-rows));
                 scrollbar-color: currentColor transparent;
                 scrollbar-width: thin;
                 scrollbar-gutter: stable;
                 scroll-snap-type: y mandatory;
               }
             }

             .scrollbox-clip[orient="horizontal"],
             #tabbrowser-arrowscrollbox {
               overflow: -moz-hidden-unscrollable;
               display: inline;
               --scrollbutton-display-model: none;
             }

             .tabbrowser-tab {
               scroll-snap-align: start;
             }

             #tabbrowser-tabs .tabbrowser-tab[pinned] {
               position: static !important;
               margin-inline-start: 0px !important;
             }

             .tabbrowser-tab[fadein]:not([pinned]) {
               min-width: var(--multirow-tab-min-width) !important;
               flex-grow: var(--multirow-tab-dynamic-width) !important;
             }

             .tabbrowser-tab>stack {
               width: 100%;
               height: 100%;
             }

             /* remove bottom margin so it doesn't throw off row height computation */
             #tabs-newtab-button {
               margin-bottom: 0 !important;
             }

             #tabbrowser-tabs[hasadjacentnewtabbutton][overflow]>#tabbrowser-arrowscrollbox>#tabbrowser-arrowscrollbox-periphery>#tabs-newtab-button {
               display: flex !important;
             }

             #alltabs-button,
             :root:not([customizing]) #TabsToolbar #new-tab-button,
             #tabbrowser-arrowscrollbox>spacer,
             .tabbrowser-tab::after {
               display: none !important;
             }

             @media (-moz-bool-pref: "userchrome.multirowtabs.full-width-tabs.enabled") {
               .tabbrowser-tab[fadein]:not([pinned]) {
                 max-width: 100vw !important;
               }
             }

             @media (-moz-bool-pref: "userchrome.multirowtabs.scrollbar-handle.enabled") {
               #tabbrowser-arrowscrollbox {
                 -moz-window-dragging: no-drag;
               }
             }

        '';
    };
  };
}
