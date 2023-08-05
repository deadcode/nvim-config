-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.cmd [[ colorscheme NeoSolarized ]]
    end
}
