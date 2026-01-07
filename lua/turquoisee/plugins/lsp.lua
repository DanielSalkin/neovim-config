return{
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {ensure_installed = {"bashls", "clangd", "jdtls", "lua_ls", "pyright", "rust_analyzer", "verible"}},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        priority = 50,
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            vim.api.nvim_set_hl(0, 'CmpBorderColor', { fg = '#5e81ac' })
            -- Autocomplete Menu
            cmp.setup({
                --disable in comments
                enabled = function()
                    local context = require 'cmp.config.context'
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                            and vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt'
                            and vim.fn.reg_recording() == ''
                            and vim.fn.reg_executing() == ''
                    end
                end,
                --set up autocomplete
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-k>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_length = 2},
                    { name = 'luasnip', keyword_length = 3},
                    { name = 'path', keyword_length = 3},
                }),
                window = {
                    completion = {
                        border = 'rounded',
                        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorderColor,CursorLine:PmenuSel,Search:None',
                        side_padding = 1,
                        scrollbar = true,
                        zindex = 1001,
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorderColor,CursorLine:PmenuSel,Search:None',
                        side_padding = 1,
                        scrollbar = true,
                        zindex = 1001,
                        max_width = 80,
                        max_height = 20,
                    }
                },
                formatting = {
                    fields = {'menu', 'abbr', 'kind'},
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp  = '[LSP]',
                            luasnip = '[SNIP]',
                            path = '[PATH]',
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end
                },
            })
            --loop through swervers and activate
            local capabilities = cmp_lsp.default_capabilities()
            local servers = {
                'bashls', --Bash
                'clangd',   -- C/C++
                'jdtls',    --Java
                'lua_ls',   -- Lua
                'pyright',  -- Python
                'rust_analyzer', --Rust
                'verible',   -- Verilog/SystemVerilog
            }
            -- enable lsp
            for _, server in ipairs(servers) do
                local opts = {
                    capabilities = capabilities,
                }
                if server == "clangd" then
                    opts.cmd = { "clangd", "--function-arg-placeholders=0" }
                end
                vim.lsp.config(server, opts)
                vim.lsp.enable(server)
            end
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')

            -- 2. Configure cmp to use autopairs
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    }
}
