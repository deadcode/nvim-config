vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/config/autocommands.vim")

vim.api.nvim_create_autocmd(
    "User",
    {
        pattern = "UnceptionEditRequestReceived",
        callback = function()
            -- Toggle the terminal off.
            require('toggleterm').toggle()
        end
    }
)
