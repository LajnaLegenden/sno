{ pkgs }:

let
  # Python packages
  pythonPackages = ps: with ps; [
    flake8
    black
    pylint
    mypy
    python-lsp-server
    pynvim  # Required for Python support in Neovim
  ];

  # Node packages for TypeScript/JavaScript development
  nodePackages = with pkgs.nodePackages; [
    eslint_d
    typescript
    typescript-language-server
    vscode-langservers-extracted  # HTML/CSS/JSON/ESLint language servers
    prettier
    jsonlint
  ];

  # Lua packages
  luaPackages = with pkgs.luajitPackages; [
    luacheck
    selene  # Lua linter
  ];

in
{
  # System packages required for the configuration
  systemPackages = with pkgs; [
    # Core development tools
    git
    ripgrep  # Required for telescope.nvim
    fd  # Required for telescope.nvim
    tree-sitter  # Required for treesitter
    
    # Language servers
    lua-language-server
    nil  # Nix language server
    rust-analyzer
    gopls
    clang-tools  # clangd language server
    
    # Linters and formatters
    statix  # Nix linter
    nixfmt-rfc-style  # Nix formatter
    shellcheck  # Shell script linter
    shfmt  # Shell formatter
    cpplint  # C/C++ linter
    golangci-lint  # Go linter
    rustfmt  # Rust formatter
    checkstyle  # Java linter
    haskellPackages.hlint  # Haskell linter
    
    # Build tools and compilers
    gcc
    gnumake
    cmake
    
    # Python with custom packages
    (python3.withPackages pythonPackages)
    
    # Node.js and npm packages
    nodejs
  ] ++ nodePackages;

  # Environment variables
  environmentVariables = {
    ESLINT_D_USE_LOCAL = "1";
    PYTHONPATH = "${pkgs.python3.withPackages pythonPackages}/lib/python3.*/site-packages";
    PATH = "$PATH:${pkgs.nodejs}/bin:${pkgs.python3}/bin";
  };
