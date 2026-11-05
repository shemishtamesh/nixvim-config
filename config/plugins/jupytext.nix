{ pkgs, ... }:
{
  plugins.jupytext.enable = true;
  extraPackages = with pkgs; [ python3Packages.jupytext ];

  extraConfigLua = /* lua */ ''
    require("jupytext.utils").get_jupytext_file = function(filename, extension)
      return vim.fn.fnamemodify(filename, ":r") .. ".generated-jupytext." .. extension
    end

    require("jupytext.utils").get_ipynb_metadata = function(filename)
      local notebook = vim.json.decode(table.concat(vim.fn.readfile(filename), "\n"))
      local metadata = notebook.metadata or {}
      local kernel = metadata.kernelspec or {}
      local info = metadata.language_info or {}
      local language = kernel.language or info.name
      if not language or language == "" then
        language = ({ python3 = "python" })[kernel.name] or "python"
      end
      local extensions = {
        py = "py", python = "py", julia = "jl", r = "r", R = "r", bash = "sh",
      }
      return {
        language = language,
        extension = extensions[language] or "md",
      }
    end
  '';
}
