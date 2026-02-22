{ ... }:
{
  programs.vesktop = {
    enable = true;
    settings = {
      customTitleBar = false;
      disableMinSize = true;
      staticTitle = true;

      arRPC = true;
      appBadge = true;
      tray = true;
      minimizeToTray = false;

      checkUpdates = false;
      hardwareAcceleration = true;
      discordBranch = "stable";

      splashTheming = true;
      splashColor = "#ffffff";
      splashBackground = "#ff81fb";

      audio = {
	workaround = true;
	deviceSelect = true;
	granularSelect = true;
	ignoreVirtual = true;
      };

      spellCheckLanguages = ["pl" "en-US"];
      openLinksWithElectron = false;
    };

    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;
      notifyAboutUpdates = false;
      useQuickCss = true;
      disableMinSize = true;

      transparent = true;
      hardwareVideoAcceleration = true;

      plugins = {
	CustomIdle = {
	  enabled = true;
	  idleTimeout = 0;
	};
        
	FakeNitro.enabled = true;
	ClearURLs.enabled = true;
	WhoReacted.enabled = true;
	ImageZoom.enabled = true;
	TypingTweaks.enabled = true;
	VoiceChatDoubleClick.enabled = true;
	BetterSettings.enabled = true;
	BiggerStreamPreview.enabled = true;
	CallTimer.enabled = true;
	CopyFileContents.enabled = true;
	ExpressionCloner.enabled = true;
	FavoriteGifSearch.enabled = true;
	FixCodeBlockGap.enabled = true;
	MentionAvatars.enabled = true;
	oneko.enabled = true;
	petpet.enabled = true;
	ReviewDB.enabled = true;
	ShikiCodeBlocks.enabled = true;
	VolumeBoster.enabled = true;
	YoutubeAdblock.enabled = true;
      };
    };
  };
}
