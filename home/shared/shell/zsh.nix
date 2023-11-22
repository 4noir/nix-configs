{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "bira";
    };
    # sessionVariables = {
    #   EDITOR = "vim";
    # };
    # envExtra = ''
    # . "$HOME/.cargo/env"
    # '';
    envExtra = ''
flac_to_wav() {
  if [ $# -eq 0 ]; then
    echo "No file path given"
return 1
  fi
  DIR="$1"
  mkdir -p "$DIR/flac"
  cp "$DIR"/*.m3u "$DIR"/flac/
  for i in "$DIR"/*.flac; do 
      echo "converting $i"
      ffmpeg -i "$i" "''${i%.*}".wav
      mv "$i" "$DIR/flac"
  done
  sed -i -E 's/(.*).flac/\1.wav/' "$DIR"/*.m3u
  tar -czvf "$DIR"/"$(basename $DIR)"_flac.tar.gz "$DIR"/flac/
  rm -rf "$DIR"/flac/
}
    '';
  };
}
