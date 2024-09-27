{
  packageOverrides = pkgs: with pkgs; {
    devPackages = pkgs.buildEnv {
      name = "alexyz";
      paths = [
        zsh
        starship
        ripgrep
        fzf
        zoxide
        lazygit
        neovim
        nodejs_22
      ];
    };
  };
}
