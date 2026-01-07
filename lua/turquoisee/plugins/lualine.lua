return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Adds file type icons
    opts = {
        options = {
            theme = "auto", 
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''}, -- Powerline arrows
            globalstatus = true,
        },
        sections = {
            lualine_a = {'mode'}, 
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {{'filename', path=0}}, 

            lualine_x = {'encoding', 'filetype', 'filesize'}, 
            lualine_y = {'progress'},
            lualine_z = {'location'}  -- Line : Column
        }
    }
}
