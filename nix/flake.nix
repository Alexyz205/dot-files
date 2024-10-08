{
  description = "Nix configuration for the macOs system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, ... }: {
        nixpkgs.config.allowUnfree = true;
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.zsh
          pkgs.starship
          pkgs.ripgrep
          pkgs.fzf
          pkgs.zoxide
          pkgs.devpod
          pkgs.tmux
          pkgs.neovim
          pkgs.lazygit
          pkgs.lazydocker
          pkgs.nodejs_22
          pkgs.cargo
        ];

        homebrew = {
          enable = true;
          casks = [
            "docker"
            "chatgpt"
            "alacritty"
            "obsidian"
          ];
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        system.defaults = {
          dock.autohide = true;
          dock.autohide-delay = 0.01;
          dock.magnification = true;
          dock.largesize = 50;
          dock.tilesize = 30;
          dock.orientation = "left";
          dock.persistent-apps = [
            "System/Applications/Alacritty.app"
            "System/Applications/Obsidian.app"
            "System/Applications/Mail.app"
            "System/Applications/Calendar.app"
          ];
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleICUForce24HourTime = true;
          NSGlobalDomain.KeyRepeat = 2;
        };

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];
        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Alexis-MBA
      darwinConfigurations."Alexis-MBA" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple silicon only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "alexis";

              autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Alexis-MBA".pkgs;
    };
}
