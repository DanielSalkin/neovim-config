return {
    'shaunsingh/nord.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
	    vim.g.nord_contrast = false
	    vim.g.nord_borders = true
	    vim.g.nord_disable_background = true 
	    vim.g.nord_italic = false
	    vim.g.nord_uniform_diff_background = true
	    vim.g.nord_bold = false
	    require('nord').set()
    end
}
