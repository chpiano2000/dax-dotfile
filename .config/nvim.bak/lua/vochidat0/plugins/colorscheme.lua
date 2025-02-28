return {
  "maxmx03/solarized.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized").setup({
      transparent = {
        enabled = false,
        pmenu = true,
        normal = true,
        normalfloat = true,
        neotree = true,
        nvimtree = true,
        whichkey = true,
        telescope = true,
        lazy = true,
      },
      styles = {
        comments = { italic = true, bold = false },
        functions = { italic = true },
        variables = { italic = false },
      },
    })
    vim.cmd.colorscheme("solarized")
  end,
}
