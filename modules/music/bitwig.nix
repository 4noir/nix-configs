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
      buildInputs = prevAttrs.buildInputs ++ (with pkgs; [ gnupg ]);
      installphase = ''
        runhook preinstall

        mkdir -p $out/bin


        # rm opt/bitwig-studio/bin/
        cp -r opt/bitwig-studio $out/libexec
        # gpg -d ${./bitwig.jar.gpg}
        cp bitwig.jar $out/libexec
        ln -s $out/libexec/bitwig-studio $out/bin/bitwig-studio
        cp -r usr/share $out/share


        substitute usr/share/applications/com.bitwig.bitwigstudio.desktop \
          $out/share/applications/com.bitwig.bitwigstudio.desktop \
          --replace /usr/bin/bitwig-studio $out/bin/bitwig-studio

          runhook postinstall
      '';
    }))
  ];
}

