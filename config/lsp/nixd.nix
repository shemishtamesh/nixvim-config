{ pkgs, ... }:
{
  lsp.servers.nixd = {
    enable = true;
    config = {
      cmd = [
        "nixd"
        "--semantic-tokens=true"
      ];
      settings.nixd =
        let
          flake_definition = /* nix */ "builtins.getFlake (toString ./.)";
          flake = /* nix */ "flake = ${flake_definition};";
          hostname = ''
            hostnameEnvVar = builtins.getEnv "HOSTNAME";
            hostname = (
              if hostnameEnvVar == "" && builtins.pathExists /etc/hostname
              then builtins.readFile /etc/hostname
              else hostnameEnvVar
            );
          '';
          username = "username = builtins.getEnv \"USER\";";
          system = "system = builtins.currentSystem;";

          flakeAndHostname = "${flake}\n${hostname}";
          flakeAndSystem = "${flake}\n${system}";
          flakeAndHostnameAndUsername = "${flake}\n${hostname}\n${username}";

          mkHostnameExpr = attrName: /* nix */ ''
            let
              ${flakeAndHostname}
            in
            if builtins.hasAttr "${attrName}" flake && builtins.hasAttr hostname flake.${attrName}
               then flake.${attrName}.''${hostname}.options
            else {}
          '';

          homeManagerExpr = /* nix */ ''
            let
              ${flakeAndHostnameAndUsername}
              homeName = if hostname == "" || username == "" then "default" else "''${username}@''${hostname}";
            in
            if builtins.hasAttr "homeConfigurations" flake && builtins.hasAttr homeName flake.homeConfigurations
               then flake.homeConfigurations.''${homeName}.options
             else {}
          '';

          nixvimExpr = /* nix */ ''
            let
              ${flakeAndSystem}
            in
            if builtins.hasAttr system flake.packages && builtins.hasAttr "default" flake.packages.''${system}
               then flake.packages.''${system}.default.options
            else {}
          '';
        in
        {
          formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
          nixpkgs.expr = /* nix */ "import ${flake_definition}.inputs.nixpkgs { }";
          options = {
            nixos.expr = mkHostnameExpr "nixosConfigurations";
            darwin.expr = mkHostnameExpr "darwinConfigurations";
            "home-manager".expr = homeManagerExpr;
            nixvim.expr = nixvimExpr;
          };
        };
    };
  };
}
