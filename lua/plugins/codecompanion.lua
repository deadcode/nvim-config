return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {
    interactions = {
      chat = {
        adapter = "auggie_cli",
      },
      inline = {
        adapter = "auggie_cli",
      },
    },
    strategies = {
      chat = {
        adapter = "auggie_cli",
      },
      inline = {
        adapter = "auggie_cli",
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "augmentcode/augment.vim",
  },
  --config = function()
  --  local codecompanion = require("codecompanion")
  --  local opts = {
  --    interactions = {
  --      chat = {
  --        adapter = "auggie_cli",
  --      },
  --      inline = {
  --        adapter = "auggie_cli",
  --      },
  --    },
  --    strategies = {
  --      chat = {
  --        adapter = "auggie_cli",
  --      },
  --      inline = {
  --        adapter = "auggie_cli",
  --      },
  --    },
  --  }
  --  codecompanion.setup(opts)
  --end,
}
