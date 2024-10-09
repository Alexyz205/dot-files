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
        neovim
        lazygit
        nodejs_22
        cargo
      ];
    };
  };
}
