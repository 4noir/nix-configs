{
    services.picom = {
        enable = true;
        activeOpacity = 0.85;
        inactiveOpacity = 0.75;
        backend = "glx";
        fade = true;
        fadeSteps = [
            0.06
            0.06
        ];
        opacityRules = [
            "100:class_g = 'Code'"
            "100:class_g = 'firefox'"
            "100:class_g = 'discord'"
            "100:class_g = 'com.bitwig.BitwigStudio'"
        ];
        shadow = false;
        vSync = true;
        settings = {
            corner-radius = 20;
            rounded-corners-exclude = [
                "window_type = 'dock'"
                "class_g = 'Rofi'"
                "window_type = 'desktop'"
                "class_g = 'dwm'"
            ];
            blur-method = "dual_kawase";
            blur-strength = 3;
            blur-background = true;
            blur-kern = "3x3box";
            blur-background-exclude = [
              "window_type = 'dock'"
              "window_type = 'desktop'"
              "class_g = 'firefox'"
              "class_g = 'dwm'"
              "class_g = 'com.bitwig.BitwigStudio'"
              "_GTK_FRAME_EXTENTS@:c"
            ];

        };

    };
}
