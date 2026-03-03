{...}: {
  programs.spotify-player = {
    enable = true;
    settings = {
      theme = "default";
      playback_window_position = "Bottom";
      cover_img_length = 9;
      cover_img_width = 9;
      cover_img_scale = 1.0;
    };
  };
}
