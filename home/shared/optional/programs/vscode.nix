{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.productIconTheme" = "material-product-icons";
      "workbench.colorTheme" = "Atom One Dark";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.defaultProfile.osx" = "zsh";
      "terminal.integrated.fontFamily" = "Cascadia Code";
      "update.mode" = "manual";
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      vscodevim.vim
      pkief.material-product-icons
      rust-lang.rust-analyzer
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-jest";
        publisher = "Orta";
        version = "5.2.3";
        sha256 = "sha256-cPHwBO7dI44BZJwTPtLR7bfdBcLjaEcyLVvl2Qq+BgE=";
      }
      {
        name = "vscode-theme-onedark";
        publisher = "akamud";
        version = "2.3.0";
        sha256 = "sha256-8GGv4L4poTYjdkDwZxgNYajuEmIB5XF1mhJMxO2Ho84=";
      }
    ];
  };
}
