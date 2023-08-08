
return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require("themery").setup({
        themes = {{
            name = "Tokyonight Night",
            colorscheme = "tokyonight-night",
          },
          {
            name = "Tokyonight Day",
            colorscheme = "tokyonight-day",
          },
          {
            name = "Default",
            colorscheme = "default",
          },
          {
            name = "Desert",
            colorscheme = "desert",
          },
          {
            name = "Gruvbox Dark",
            colorscheme = "gruvbox",
          },
          {
            name = "Lunaperche",
            colorscheme = "lunaperche",
          },
          {
            name = "Habamax",
            colorscheme = "habamax",
          },
          {
            name = "Pechpuff",
            colorscheme = "peachpuff",
          },
          {
            name = "Solarized Light",
            colorscheme = "solarized",
            before = [[
              vim.opt.background = "light"
            ]],
          },
          {
            name = "Solarized Dark",
            colorscheme = "solarized",
            before = [[
              vim.opt.background = "dark"
            ]],
          },
        },
    })
  end,
}
