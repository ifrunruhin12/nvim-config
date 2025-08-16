-- Custom Lua snippets for Neovim configuration
-- Place this file at: lua/snippets/lua.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

return {
    -- Plugin configuration template
    s("plugin", {
        t("return {"),
        t({
            "",
            '  "',
        }),
        i(1, "author/plugin-name"),
        t('",'),
        t({
            "",
            "  config = function()",
            "    ",
        }),
        i(2, "-- plugin configuration"),
        t({
            "",
            "  end,",
            "}",
        }),
    }),

    -- Require statement
    s("req", {
        t("local "),
        i(1, "name"),
        t(' = require("'),
        i(2, "module"),
        t('")'),
    }),

    -- Function definition
    s("func", {
        t("local function "),
        i(1, "name"),
        t("("),
        i(2, "args"),
        t({
            ")",
            "  ",
        }),
        i(3, "-- function body"),
        t({
            "",
            "end",
        }),
    }),

    -- Anonymous function
    s("function", {
        t("function("),
        i(1, "args"),
        t({
            ")",
            "  ",
        }),
        i(2, "-- function body"),
        t({
            "",
            "end",
        }),
    }),

    -- For loop
    s("for", {
        t("for "),
        i(1, "i = 1, 10"),
        t({
            " do",
            "  ",
        }),
        i(2, "-- loop body"),
        t({
            "",
            "end",
        }),
    }),

    -- For pairs loop
    s("forp", {
        t("for "),
        i(1, "key, value"),
        t(" in pairs("),
        i(2, "table"),
        t({
            ") do",
            "  ",
        }),
        i(3, "-- loop body"),
        t({
            "",
            "end",
        }),
    }),

    -- For ipairs loop
    s("fori", {
        t("for "),
        i(1, "i, value"),
        t(" in ipairs("),
        i(2, "table"),
        t({
            ") do",
            "  ",
        }),
        i(3, "-- loop body"),
        t({
            "",
            "end",
        }),
    }),

    -- If statement
    s("if", {
        t("if "),
        i(1, "condition"),
        t({
            " then",
            "  ",
        }),
        i(2, "-- if body"),
        t({
            "",
            "end",
        }),
    }),

    -- If-else statement
    s("ife", {
        t("if "),
        i(1, "condition"),
        t({
            " then",
            "  ",
        }),
        i(2, "-- if true"),
        t({
            "",
            "else",
            "  ",
        }),
        i(3, "-- if false"),
        t({
            "",
            "end",
        }),
    }),

    -- Table definition
    s("table", {
        t("local "),
        i(1, "name"),
        t({
            " = {",
            "  ",
        }),
        i(2, "-- table contents"),
        t({
            "",
            "}",
        }),
    }),

    -- Vim keymap
    s("keymap", {
        t('vim.keymap.set("'),
        i(1, "n"),
        t('", "'),
        i(2, "<leader>k"),
        t('", '),
        i(3, "function()"),
        t(', { desc = "'),
        i(4, "Description"),
        t('" })'),
    }),

    -- Vim option
    s("opt", {
        t("vim.opt."),
        i(1, "option"),
        t(" = "),
        i(2, "value"),
    }),

    -- Vim global
    s("g", {
        t("vim.g."),
        i(1, "variable"),
        t(" = "),
        i(2, "value"),
    }),

    -- Vim autocmd
    s("autocmd", {
        t('vim.api.nvim_create_autocmd("'),
        i(1, "BufWritePre"),
        t('", {'),
        t({
            "",
            '  pattern = "',
        }),
        i(2, "*"),
        t('",'),
        t({
            "",
            "  callback = function()",
            "    ",
        }),
        i(3, "-- callback code"),
        t({
            "",
            "  end,",
            "})",
        }),
    }),

    -- LSP on_attach function
    s("on_attach", {
        t({
            "local on_attach = function(client, bufnr)",
            "  local opts = { buffer = bufnr, silent = true }",
            "  ",
        }),
        i(1, "-- keymaps and setup"),
        t({
            "",
            "end",
        }),
    }),

    -- Print statement
    s("print", {
        t("print("),
        i(1, "value"),
        t(")"),
    }),

    -- Vim notify
    s("notify", {
        t('vim.notify("'),
        i(1, "message"),
        t('", vim.log.levels.'),
        c(2, {
            t("INFO"),
            t("WARN"),
            t("ERROR"),
            t("DEBUG"),
        }),
        t(")"),
    }),

    -- Comment block
    s("comment", {
        t("-- "),
        f(function()
            return string.rep("=", 50)
        end),
        t({
            "",
            "-- ",
        }),
        i(1, "Section Title"),
        t({
            "",
            "-- ",
        }),
        f(function()
            return string.rep("=", 50)
        end),
    }),

    -- Module return
    s("return", {
        t({
            "return {",
            "  ",
        }),
        i(1, "-- module contents"),
        t({
            "",
            "}",
        }),
    }),

    -- Packer/Lazy plugin spec
    s("spec", {
        t("{"),
        t({
            "",
            '  "',
        }),
        i(1, "author/plugin"),
        t('",'),
        t({
            "",
            "  dependencies = { ",
        }),
        i(2, "-- dependencies"),
        t(" },"),
        t({
            "",
            "  config = function()",
            "    ",
        }),
        i(3, "-- configuration"),
        t({
            "",
            "  end,",
            "},",
        }),
    }),

    -- Telescope setup
    s("telescope", {
        t({
            'require("telescope").setup({',
            "  defaults = {",
            "    ",
        }),
        i(1, "-- default options"),
        t({
            "",
            "  },",
            "  pickers = {",
            "    ",
        }),
        i(2, "-- picker options"),
        t({
            "",
            "  },",
            "  extensions = {",
            "    ",
        }),
        i(3, "-- extension options"),
        t({
            "",
            "  },",
            "})",
        }),
    }),
}
