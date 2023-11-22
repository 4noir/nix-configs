{
    programs.rofi = {
        enable = true;
        extraConfig = {
            modi =  "run,drun,window";
            lines =  5;
            font =  "Iosevka 12";
            show-icons =  true;
            icon-theme =  "Paper Mono";
            terminal =  "alacritty";
            drun-display-format =  "{icon} {name}";
            location =  0;
            disable-history =  false;
            hide-scrollbar =  true;
            display-drun =  "   Apps ";
        };
        theme = ./theme.rasi;
    };
    home.file.rofithemes = {
        enable = true;
        recursive = true;
        source = ./themes;
        target = ".config/rofi/themes";
    };

}
