{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ vim-tpipeline ];
  extraConfigLua = ''
    if vim.env.TMUX then
      vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme", "VimResized" }, {
        callback = function()
          vim.defer_fn(function()
            vim.opt.laststatus = 1
          end, 100)
        end,
      })

      vim.o.laststatus = 1
    end
  '';

  plugins.tmux-navigator = {
    enable = true;
    settings.no_mappings = 1;
  };
  keymaps =
    let
      commandPrefix = "TmuxNavigate";
      keyToCommandSuffixes = {
        "<m-h>" = "Left";
        "<m-j>" = "Down";
        "<m-k>" = "Up";
        "<m-l>" = "Right";
        "<m-bs>" = "Previous";
      };
      keyToDescriptions = {
        "<m-h>" = "Tmux navigate left";
        "<m-j>" = "Tmux navigate down";
        "<m-k>" = "Tmux navigate up";
        "<m-l>" = "Tmux navigate right";
        "<m-bs>" = "Tmux navigate previous";
      };
      modePatterns = command: {
        "n" = ":${command}<cr>";
        "v" = ":<c-u>${command}<cr>gv";
        "i" = "<c-o>:${command}<cr>";
        "t" = "<c-\\><c-o>:${command}<cr>";
      };
      keymap_options = {
        silent = true;
      };
      keysAndCommands = builtins.attrValues (
        builtins.mapAttrs (key: suffix: {
          inherit key;
          command = commandPrefix + suffix;
        }) keyToCommandSuffixes
      );
      keysAndPerModeActions = map (keyAndCommand: {
        inherit (keyAndCommand) key;
        modesToActions = modePatterns keyAndCommand.command;
      }) keysAndCommands;
    in
    builtins.concatLists (
      map (
        keyAndPerMode:
        builtins.attrValues (
          builtins.mapAttrs (mode: action: {
            inherit mode action;
            key = keyAndPerMode.key;
            options = keymap_options // { desc = keyToDescriptions.${keyAndPerMode.key}; };
          }) keyAndPerMode.modesToActions
        )
      ) keysAndPerModeActions
    );
}
