{ lib, ... }:

{
  plugins = {
    minuet = {
      enable = true;
      settings = {
        provider = "openai_fim_compatible";
        n_completions = 1;
        context_window = 512;
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
      };
    };
    cmp = {
      settings = {
        sources = lib.mkBefore [ { name = "minuet"; } ];
        performance.fetching_timeout = 2000;
      };
    };
  };
}
