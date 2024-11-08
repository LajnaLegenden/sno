{ lib, config, ... }:
{
  options = {
    nvim-lint.enable = lib.mkEnableOption "Enable nvim-lint module";
  };
  config = lib.mkIf config.nvim-lint.enable {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        c = [ "cpplint" ];
        cpp = [ "cpplint" ];
        go = [ "golangci-lint" ];
        nix = [ "statix" ];
        lua = [ "selene" ];
        python = [ "flake8" ];
        javascript = [ "eslint_d" ];
        javascriptreact = [ "eslint_d" ];
        typescript = [ "eslint_d" ];
        typescriptreact = [ "eslint_d" ];
        json = [ "jsonlint" ];
        java = [ "checkstyle" ];
        haskell = [ "hlint" ];
        bash = [ "shellcheck" ];
      };
    };
        environment.systemPackages = with pkgs; [
      # C/C++
      cpplint

      # Go
      golangci-lint

      # Nix
      statix

      # Lua
      selene

      # Python
      python3Packages.flake8

      # JavaScript/TypeScript
      nodePackages.eslint_d

      # JSON
      nodePackages.jsonlint

      # Java
      checkstyle

      # Haskell
      haskellPackages.hlint

      # Shell
      shellcheck
    ];
  };
}
