{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
  };

  home.file = {
    ".config/nvim/".source = "${pkgs.nvchad}/share/nvchad";
  };
}
