{ lib, utils, ... }:
{
  plugins.codecompanion = {
    enable = true;
    settings = {
      opts.completion_provider = "cmp";
      display = {
        action_palette.provider = "telescope";
        chat.start_in_insert_mode = true;
      };
      interactions =
        lib.genAttrs [ "chat" "background" "cmd" ] (_: {
          adapter = {
            name = "ollama";
            model = "ornith";
          };
        })
        // {
          inline = {
            adapter = {
              name = "ollama";
              model = "qwen2.5-coder:7b";
            };
          };
          cli = {
            agent = "opencode";
            agents.opencode.cmd = "opencode";
            opts.reload = true;
          };
        };
      adapters.acp = {
        opts.show_presets = false;
        opencode.__raw = ''
          function()
            return require("codecompanion.adapters").extend("opencode", {})
          end
        '';
      };
      adapters.http = {
        opts.show_presets = false;
        ollama.__raw = ''
          function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "Ollama"
            })
          end
        '';
        openrouter.__raw = ''
          function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "Open Router",
              formatted_name = "Open Router",
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "openrouter/free",
                },
              },
            })
          end
        '';
      };
    };
  };
  keymaps = [
    (utils.map [ "n" "v" ] "<M-a>" "<cmd>CodeCompanion<cr>" { desc = "CodeCompanion"; })
    (utils.map [
      "n"
      "v"
    ] "<leader>ap" ''<cmd>lua require("codecompanion").cli({ prompt = true })<cr>'' { desc = "CodeCompanion CLI (prompt)"; })
    (utils.map [ "n" "v" ] "<leader>ac" "<cmd>CodeCompanionCLI<cr>" { desc = "CodeCompanion CLI"; })
    (utils.map [ "n" "v" ] "<leader><C-a>" "<cmd>CodeCompanionActions<cr>" { desc = "CodeCompanion actions"; })
    (utils.map "n" "<leader>A" "<cmd>CodeCompanionChat Toggle<cr>" { desc = "Toggle CodeCompanion chat"; })
    (utils.map "v" "<leader>A" "<cmd>CodeCompanionChat Add<cr>" { desc = "Add selection to chat"; })
    (utils.map "ca" "CC" "CodeCompanion" { })
  ];
  extraConfigLua = builtins.readFile ./config.lua;
}
