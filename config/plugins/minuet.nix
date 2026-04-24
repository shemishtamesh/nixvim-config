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
          openai_compatible = {
            api_key = "OPENROUTER_API_KEY";
            name = "Openrouter";
            end_point = "https://openrouter.ai/api/v1/chat/completions";
            model = "openrouter/free";
            optional = {
              temperature = 0;
              max_tokens = 56;
              provider = {
                sort = "throughput";
              };
            };
          };
        };
        add_single_line_entry = true;
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
