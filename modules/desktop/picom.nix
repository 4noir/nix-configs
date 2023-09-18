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
            "90:class_g = 'eww-eww'"
            "100:class_g = 'discord'"
            "100:class_g = 'dwm'"
            "100:class_g = 'com.bitwig.BitwigStudio'"
            "100:window_type = 'desktop'"
        ];
        shadow = false;
        vSync = true;
        settings = {
            corner-radius = 20;
            rounded-corners-exclude = [
                "class_g = 'Rofi'"
                "window_type = 'desktop'"
                # "class_g = 'dwm'"
            ];
            blur-method = "dual_kawase";
            blur-strength = 3;
            blur-background = true;
            blur-kern = "3x3box";
            blur-background-exclude = [
              "window_type = 'desktop'"
              "class_g = 'firefox'"
              "class_g = 'dwm'"
              "class_g = 'com.bitwig.BitwigStudio'"
              "_GTK_FRAME_EXTENTS@:c"
            ];

        };

    };
}
