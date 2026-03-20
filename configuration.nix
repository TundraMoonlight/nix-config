# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "moonlight"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tundra = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "tundra";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [

    ];
  };

  environment.sessionVariables = {
    FLAKE = "/home/tundra/config/";
    NH_FLAKE = "/home/tundra/config/";
  };

  services.playerctld.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      nixupdate = "nh os switch";
    };
    shellInit = ''
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      set -gx NH_FLAKE /home/tundra/config/

      function starship_transient_prompt_func
        starship module character
      end
      starship init fish | source
      enable_transience
    '';
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/tundra/Music";
    startWhenNeeded = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vesktop
    rmpc
    rofi
    swww
    mpdris2
    mpc
    kitty
    proton-pass
    nh
    nwg-look
    brightnessctl
  ];
}
