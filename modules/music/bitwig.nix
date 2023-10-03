{pkgs-unstable, conf, ...}:

{
  environment.systemPackages = with pkgs-unstable; [
	  (bitwig-studio.overrideAttrs {
         version = "5.0.4";

	  })
  ];
}

