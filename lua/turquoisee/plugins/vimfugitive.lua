return{
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set('n', '<leader>git', ":Git")
	end
}
