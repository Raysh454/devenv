local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Refactoring rebinds
local on_attach = function(client, bufnr)
    -- Example: inside your LSP on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Go to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- Go to declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    -- Go to implementation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- Go to type definition
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

    -- Hover documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Signature help
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Rename symbol
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Code actions
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Show diagnostics (float)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    -- Go to next/previous diagnostic
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Format document (async)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
end

local servers = { "pyright", "lua_ls", "clangd", "java_language_server", "eslint", "rust_analyzer", "nimls", "zls", "gopls", "omnisharp", "ts_ls", "cssls" }

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local nvim_lsp = require('lspconfig')

for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
end

-- require("mason-lspconfig").setup_handlers({
--    function(server_name)
--        require("lspconfig")[server_name].setup({
--            capabilities = capabilities,
--            on_attach = on_attach,
--        })
--    end,
--})

local cmp = require('cmp')
local cmp_autopairs = require("nvim-autopairs.completion.cmp");

-- diagnostic messages
vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            return diagnostic.message
        end
    }
})


cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'buffer' },
        { name = 'path' }
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
