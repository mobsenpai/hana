''
  // Arkenfox User.js
  ${builtins.readFile "${pkgs.arkenfox}/share/arkenfox/user.js"}

  // Arkenfox overrides
  user_pref('keyword.enabled', true);
  user_pref("privacy.resistFingerprinting", false);
  user_pref('privacy.resistFingerprinting.letterboxing', false);
  user_pref('privacy.sanitize.sanitizeOnShutdown', false);
  user_pref('privacy.clearOnShutdown.offlineApps', false);
  user_pref("browser.startup.page", 3);
  user_pref("browser.newtabpage.enabled", true);
  user_pref("media.eme.enabled", true);
  user_pref("network.http.referer.XOriginPolicy", 0);
''
