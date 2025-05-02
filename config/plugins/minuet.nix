{ lib, ... }:

{
  plugins = {
    minuet = {
      enable = true;
      settings = {
        provider = "openai_fim_compatible";
        n_completions = 1;
        context_window = 2048;
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM";
            name = "Ollama";
            end_point = "http://localhost:11434/v1/completions";
            model = "qwen2.5-coder:7b";
            optional = {
              temperature = 0;
              max_tokens = 56;
            };
          };
        };
        add_single_line_entry = false;
      };
    };
    cmp = {
      settings = {
        sources = lib.mkBefore [ { name = "minuet"; } ];
        performance.fetching_timeout = 2000;
      };
    };
    # lsp.servers.vectorcode_server = {
    #   enable = true;
    # };
  };
  # TODO: find out how to make vectorcode work
  # extraPlugins = with pkgs; [
  #   (vimUtils.buildVimPlugin {
  #     pname = "vectorcode";
  #     version = "latest";
  #     src = fetchFromGitHub {
  #       owner = "Davidyz";
  #       repo = "VectorCode";
  #       rev = "main";
  #       sha256 = "sha256-I6YuX09a2C9Ik1uO1Z78ACIPgzhJ9jl6ixVDSW8+Awo=";
  #     };
  #   })
  # ];

  # extraConfigLua = # lua
  #   "require('vectorcode').setup()";
  # extraPackages = with pkgs; [ vectorcode ];
}
