{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "ethersync-nvim";
      version = "latest";
      src = fetchFromGitHub {
        owner = "ethersync";
        repo = "ethersync-nvim";
        rev = "master";
        sha256 = "sha256-LLQoiTY5Wc3V3EkZ0BVUIjgPUaLCe/xaF+SaB9vkzo4=";
      };
    })
  ];
}
