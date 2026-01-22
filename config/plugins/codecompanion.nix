{ lib, ... }:
{
  plugins = {
    codecompanion = {
      enable = true;
      settings = {
        opts = {
          completion_provider = "cmp";
          adapters = {
            # acp = {
            #   opencode.__raw = ''
            #       function()
            #         return require("codecompanion.adapters").extend("opencode", {
            #           defaults = {
            #           model = "ollama/devstral-small-2"
            #         };
            #       })
            #     end'';
            # };
            # http = {
            #   ollama.__raw = ''
            #     function()
            #       return require("codecompanion.adapters").extend("ollama", {
            #         env = {
            #           url = "https://localhost",
            #         },
            #         headers = {
            #           ["Content-Type"] = "application/json",
            #         },
            #         parameters = {
            #           sync = true,
            #         },
            #       })
            #     end
            #   '';
            # };
          };
        };
        interactions = lib.genAttrs [ "chat" "inline" "background" "cmd" ] (_: {
          # adapter = "ollama";
          adapter = "opencode";
          # adapter = {
          #   name = "opencode";
          #   model = "ollama/devstral-small-2";
          # };
        });
      };
    };
  };
}
