{pkgs, conf, ...}:

{
  environment.systemPackages = with pkgs; [
    (bitwig-studio.overrideAttrs (finalAttrs: prevAttrs: {
      pname = prevAttrs.pname;
      version = "5.0.4";
      src = fetchurl {
        url = "https://downloads.bitwig.com/stable/${finalAttrs.version}/${prevAttrs.pname}-${finalAttrs.version}.deb";
        sha256 = "sha256-IkhUkKO+Ay1WceZNekII6aHLOmgcgGfx0hGo5ldFE5Y=";
      };
      buildInputs = prevAttrs.buildInputs ++ (with pkgs; [ gnupg tree ]);
      installPhase = ''
        runHook preInstall

        rm opt/bitwig-studio/bin/bitwig.jar
        cp ${./bitwig.jar} opt/bitwig-studio/bin/bitwig.jar
        cp ${./bitwig.jar} opt/bitwig-studio/bin/bitwig-cracked.jar

        mkdir -p $out/bin
        cp -r opt/bitwig-studio $out/libexec
        ln -s $out/libexec/bitwig-studio $out/bin/bitwig-studio
        cp -r usr/share $out/share
        substitute usr/share/applications/com.bitwig.BitwigStudio.desktop \
          $out/share/applications/com.bitwig.BitwigStudio.desktop \
          --replace /usr/bin/bitwig-studio $out/bin/bitwig-studio

        runHook postInstall
        '';
    }))
  ];
}

