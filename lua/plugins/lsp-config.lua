-- Enhanced LSP Configuration with nvim-cmp integration

return {
    -- Mason - LSP server manager
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- Mason LSP Config
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", -- Lua
                    "gopls", -- Go
                    "pyright", -- Python
                },
                automatic_installation = true,
            })
        end,
    },

    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp", -- LSP completion source
        },
        config = function()
            local lspconfig = require("lspconfig")

            -- Enhanced capabilities with nvim-cmp
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- Enable snippet support
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            }

            -- Common on_attach function
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                -- LSP keymaps
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)

                -- Enhanced diagnostics navigation
                vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, opts)

                -- Show signature help
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

                -- Workspace management
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)

                -- Enable inlay hints if supported (for newer LSP servers)
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end

                -- Highlight references under cursor
                if client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_augroup("lsp_document_highlight", {
                        clear = false,
                    })
                    vim.api.nvim_clear_autocmds({
                        buffer = bufnr,
                        group = "lsp_document_highlight",
                    })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        group = "lsp_document_highlight",
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                        group = "lsp_document_highlight",
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end

            -- Diagnostic signs (using modern vim.diagnostic API)
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- Nice bullet point
                    source = "if_many", -- Show source if multiple LSPs attached
                    spacing = 2,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                -- Reduce duplicate diagnostics
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Lua LSP (Enhanced configuration)
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            globals = { "vim", "use", "describe", "it", "assert", "before_each", "after_each" },
                            disable = {
                                "missing-fields",
                                "incomplete-signature-doc",
                                "inject-field",
                                "undefined-field",
                            },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                        completion = {
                            callSnippet = "Replace",
                            keywordSnippet = "Replace",
                            displayContext = 5,
                        },
                        format = {
                            enable = false, -- Use stylua via none-ls instead
                        },
                        hint = {
                            enable = true, -- Enable inlay hints
                            arrayIndex = "Disable",
                            await = true,
                            paramName = "Disable",
                            paramType = true,
                            semicolon = "Disable",
                            setType = false,
                        },
                    },
                },
            })

            -- Go LSP (Enhanced configuration)
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                            nilness = true,
                            unusedwrite = true,
                        },
                        staticcheck = true,
                        gofumpt = true, -- Use gofumpt for stricter formatting
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = false,
                            compositeLiteralFields = false,
                            compositeLiteralTypes = false,
                            constantValues = true,
                            functionTypeParameters = false,
                            parameterNames = false,
                            rangeVariableTypes = false,
                        },
                    },
                },
                init_options = {
                    usePlaceholders = true,
                },
            })

            -- Python LSP (Enhanced configuration)
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                            typeCheckingMode = "basic", -- Can be "off", "basic", or "strict"
                            autoImportCompletions = true,
                            indexing = true,
                        },
                    },
                },
            })

            -- Show LSP status in statusline (if not using lualine)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client then
                        vim.notify("LSP " .. client.name .. " attached to buffer", vim.log.levels.INFO)
                    end
                end,
            })

            -- Automatically show signature help in insert mode
            vim.api.nvim_create_autocmd("CursorHoldI", {
                pattern = "*",
                callback = function()
                    local clients = vim.lsp.get_active_clients()
                    if #clients > 0 then
                        for _, client in pairs(clients) do
                            if client.server_capabilities.signatureHelpProvider then
                                vim.lsp.buf.signature_help()
                                break
                            end
                        end
                    end
                end,
                desc = "Show signature help in insert mode",
            })

            -- Format on save for specific filetypes
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.go", "*.lua" },
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
                desc = "Format Go and Lua files on save",
            })
        end,
    },
}
