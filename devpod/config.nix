{
  packageOverrides = pkgs: with pkgs; {
    devPackages = pkgs.buildEnv {
      name = "alexyz";
      paths = [
        starship
        ripgrep
        fzf
        zoxide
        lazygit
        neovim
      ];
    };
  };
}
