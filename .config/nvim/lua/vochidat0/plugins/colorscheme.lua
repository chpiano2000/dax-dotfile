-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme rose-pine-dawn")
--   end,
-- }

return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("gruvbox")
  end,
}
