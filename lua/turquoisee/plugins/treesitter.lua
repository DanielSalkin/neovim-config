return { 
    'nvim-treesitter/nvim-treesitter',
    lazy = false, build = ':TSUpdate',
    config = function() 
        require'nvim-treesitter'.install { 'bash', 'c', 'cmake', 'cpp', 'java', 'javascript', 'json', 'lua', 'make', 'markdown', 'python', 'query', 'rust', 'systemverilog', 'toml', 'vimdoc', 'yaml', 'zsh' } 
	vim.treesitter.language.register('systemverilog', 'verilog')
	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'sh', 'c', 'cmake', 'cpp', 'help', 'java', 'javascript', 'json', 'lua', 'make', 'markdown', 'python', 'query', 'rust', 'systemverilog', 'toml', 'yaml', 'zsh' },
		callback = function() vim.treesitter.start() end,
	})
	vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "java", "lua", "rust", "systemverilog","verilog" },
            callback = function()
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'
		vim.wo.foldenable = false
            end,
        })
    end 
} 
