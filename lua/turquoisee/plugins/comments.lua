return{
    'numToStr/Comment.nvim',
    opts = {},
    config = function(_, opts)
        local comment = require('Comment')
        comment.setup(opts)
        local api = require('Comment.api')
        vim.keymap.set('n', '<leader>c', api.toggle.linewise.current, { desc = "Comment line" })
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.keymap.set('x', '<leader>c', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.linewise(vim.fn.visualmode())
        end, { desc = "Comment selection" })
        vim.keymap.set('x', '<leader>bc', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.blockwise(vim.fn.visualmode())
        end)
    end
}
