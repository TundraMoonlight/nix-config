{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.catppuccin.homeModules.catppuccin
    inputs.nvf.homeManagerModules.default
  ];

  fonts.fontconfig.enable = true;

  home.username = "tundra";
  home.homeDirectory = "/home/tundra";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    FLAKE = "/home/tundra/config/";
    NH_FLAKE = "/home/tundra/config/";
  };

  home.packages = with pkgs; [
    cava
    inter
    jq
    hyprshot

    nerd-fonts.blex-mono
    nerd-fonts.liberation
    nerd-fonts.fira-code
    nerd-fonts.adwaita-mono
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
  ];

  catppuccin = {
    enable = true;
    accent = "blue";

    fish.enable = true;
    yazi.enable = false;

    cursors = {
      enable = true;
      accent = "dark";
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        settings = {

          monitor = ",preferred,auto,auto";

          "$terminal" = "kitty";
          "$fileManager" = "nautilus";
          "$menu" = "rofi -show drun -theme '~/.config/rofi/themes/launcher.rasi'";
          "$mainMod" = "SUPER";
          "$altMod" = "ALT";

          env = [
            "XCURSOR_SIZE,24"
            "HYPRCURSOR_SIZE,24"
          ];

          general = {
            gaps_in = 5;
            gaps_out = 12;

            border_size = 0;

            layout = "scrolling";
          };

          decoration = {
            rounding = 12;
            rounding_power = 2;
          };

          animations = {
            enabled = true;

            bezier = [
              "linear, 0, 0, 1, 1"
              "md3_standard, 0.2, 0, 0, 1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.1"
              "crazyshot, 0.1, 1.5, 0.76, 0.92"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "menu_decel, 0.1, 1, 0, 1"
              "menu_accel, 0.38, 0.04, 1, 0.07"
              "easeInOutCirc, 0.85, 0, 0.15, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutExpo, 0.16, 1, 0.3, 1"
              "softAcDecel, 0.26, 0.26, 0.15, 1"
              "md2, 0.4, 0, 0.2, 1"
            ];

            animation = [
             "windows, 1, 3, md3_decel, popin 60%"
             "windowsIn, 1, 3, md3_decel, popin 60%"
             "windowsOut, 1, 3, md3_accel, popin 60%"
             "border, 1, 10, default"
             "layersIn, 1, 3, menu_decel, slide"
             "layersOut, 1, 1.6, menu_accel"
             "fadeLayersIn, 1, 2, menu_decel"
             "fadeLayersOut, 1, 4.5, menu_accel"
             "workspaces, 1, 7, menu_decel, slidevert"
             "specialWorkspace, 1, 3, md3_decel, slidevert"
            ];
            };

            scrolling = {
              fullscreen_on_one_column = true;
              column_width = 0.8;
              direction = "right";
            };

            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
            };

            input = {
              kb_layout = "us";
              follow_mouse = 1;
              sensitivity = 0.15;

              touchpad = {
                tap_and_drag = false;
                natural_scroll = false;
              };
            };

            gesture = [

              "3, vertical, workspace"
              "3, left, dispatcher, layoutmsg, move +col"
              "3, right, dispatcher, layoutmsg, move -col"
              "3, pinchOut, float"
              "4, left, dispatcher, layoutmsg, colresize -0.2"
              "4, right, dispatcher, layoutmsg, colresize +0.2"
            ];

            bind = [
              "$mainMod, T, exec, $terminal"
              "$mainMod, Q, killactive,"
              "$mainMod, Super_L, exec, $menu"

              "$mainMod, left, movefocus, l"
              "$mainMod, right, movefocus, r"
              "$mainMod, up, movefocus, u"
              "$mainMod, down, movefocus, d"

              "$mainMod, period, layoutmsg, move +col"
              "$mainMod, comma, layoutmsg, move -col"
              "$mainMod SHIFT, period, layoutmsg, swapcol r"
              "$mainMod SHIFT, comma, layoutmsg, swapcol l"

              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, 6, workspace, 6"
              "$mainMod, 7, workspace, 7"
              "$mainMod, 8, workspace, 8"
              "$mainMod, 9, workspace, 9"
              "$mainMod, 0, workspace, 10"

              "$mainMod SHIFT, 1, movetoworkspace, 1"
              "$mainMod SHIFT, 2, movetoworkspace, 2"
              "$mainMod SHIFT, 3, movetoworkspace, 3"
              "$mainMod SHIFT, 4, movetoworkspace, 4"
              "$mainMod SHIFT, 5, movetoworkspace, 5"
              "$mainMod SHIFT, 6, movetoworkspace, 6"
              "$mainMod SHIFT, 7, movetoworkspace, 7"
              "$mainMod SHIFT, 8, movetoworkspace, 8"
              "$mainMod SHIFT, 9, movetoworkspace, 9"
              "$mainMod SHIFT, 0, movetoworkspace, 10"

              "$altMod, Z, togglespecialworkspace, music"
              "$altMod, X, togglespecialworkspace, discord"
              "$altMod, C, togglespecialworkspace, terminal"

              "$altMod SHIFT, Z, movetoworkspace, special:music"
              "$altMod SHIFT, X, movetoworkspace, special:discord"
              "$altMod SHIFT, C, movetoworkspace, special:terminal"
            ];

            bindl = [
              ", XF86AudioNext, exec, playerctl next"
              ", XF86AudioPause, exec, playerctl play-pause"
              ", XF86AudioPlay, exec, playerctl play-pause"
              ", XF86AudioPrev, exec, playerctl previous"
            ];

            bindel = [
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
              ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
              ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
              ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
            ];

            windowrule = [
              "match:class .*, suppress_event maximize"
            ];
        };
      };
    };
  };

  services = {
    hypridle.enable = true;

    # hypridle = {
    #   general = {
    #     lock_cmd = sddm
    #   };
    #
    #   listener = {
    #
    #   };
    # };
  };

  programs = {
    firefox.enable = true;
    zen-browser.enable = true;
    neovim.enable = true;
    nh.enable = true;
    starship.enable = true;
    hyprshot.enable = true;

    starship = {
      enableTransience = true;
      enableFishIntegration = true;

      settings = {
        format = lib.concatStrings [
          "$os"
          "$username"
          "$hostname"
          "$directory"
          "$character"
        ];

        os = {
          disabled = false;
          style = "bg:#89b4fa fg:#313244 bold";
          format = "[](fg:#89b4fa)[$symbol]($style)";
          symbols = { NixOS = " "; };
        };

        username = {
          show_always = true;
          style_user = "bg:#89b4fa fg:#313244 bold";
          format = "[$user@]($style)";
        };

        hostname = {
          ssh_only = false;
          style = "bg:#89b4fa fg:#313244 bold";
          format = "[$hostname]($style)[](fg:#89b4fa bg:#313244)";
        };

        directory = {
          style = "bg:#313244 fg:#89b4fa";
          format = "[](fg:#313244 bg:#313244)[󰉋 $path]($style)[](fg:#313244)";
        };

        character = {
          success_symbol = "[ ](fg:blue)";
          error_symbol = "[ ](fg:red)";
        };
      };
    };

    nvf = {
      enable = true;

      settings.vim = {
        undoFile.enable = true;
        autopairs.nvim-autopairs.enable = true;
        lineNumberMode = "number";

        options = {
          tabstop = 2;
          shiftwidth = 2;
          tm = 300;
        };

        keymaps = [
          {
            key = "<leader>w";
            mode = "n";
            action = ":w<cr>";
          }

          {
            key = "<C-a>";
            mode = "n";
            action = "gg<S-v>G";
          }

          {
            key = ">";
            mode = "v";
            action = ">gv";
          }

          {
            key = "<";
            mode = "v";
            action = "<gv";
          }
        ];

        clipboard = {
          enable = true;

          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };

        formatter = {
          conform-nvim.enable = true;
        };

        utility = {
          icon-picker.enable = true;

          images = {
            image-nvim = {
              enable = true;
              setupOpts.backend = "kitty";
            };
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          indent-blankline.enable = true;
          tiny-devicons-auto-colors.enable = true;
        };

        ui = {
          noice.enable = true;
        };

        autocomplete = {
          blink-cmp = {
            enable = true;

            mappings = {
                next = "<Down>";
                previous = "<Up>";
            };

            setupOpts = {
              completion.menu = {
                border = "rounded";
              };
            };
          };
        };

        lsp = {
          enable = true;
          trouble.enable = true;

          formatOnSave = true;
        };

        languages = {
          nix.enable = true;
          html.enable = true;
          css.enable = true;
          ts.enable = true;

          html = {
            extraDiagnostics.enable = true;
          };

          nix = {
            extraDiagnostics.enable = true;

            lsp.servers = [ "nixd" ];
          };
        };

        statusline = {
          lualine = {
            enable = true;

            activeSection = {
              a = [
                ''
                  {
                      "mode",
                      icons_enabled = true,
                      separator = { 
                          left = "", 
                          right = "",
                      },
                  }
                ''
              ];

              b = [
                ''
                  {
                    "filename",

                    icon = "",
                    colored = true,
                    symbols = {
                      modified = "󰏫",
                      readonly = "",
                      unnamed = "",
                      newfile = "",
                    },
                    separator = {right = ''}
                  }
                ''
              ];
              x = [
                ''
                  {
                    "diagnostics",
                    sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
                    symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
                    colored = true,
                    update_in_insert = false,
                    always_visible = false,
                    diagnostics_color = {
                      color_error = { fg = 'red' },
                      color_warn = { fg = 'yellow' },
                      color_info = { fg = 'cyan' },
                    },
                  }
                ''
              ];
              y = [
                ''
                  {
                    "filetype",
                    icon = { align = 'right' },
                    icon_only = true,
                    colored = true,
                    separator = { left = "" }
                  }
                ''
              ];
              z = [
                ''
                  {
                    "location",

                    separator = { 
                      left = "", 
                      right = "",
                    },
                  }
                ''
              ];
            };
          };
        };
      };
    };

    nh = {
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/tundra/config/";
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
