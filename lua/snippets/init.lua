-- Snippet directory initialization
-- Place this file at: lua/snippets/init.lua
-- This file loads all custom snippets from the snippets directory

local ls = require("luasnip")

-- Load Go snippets
ls.add_snippets("go", require("snippets.go"))

-- Load Lua snippets
ls.add_snippets("lua", require("snippets.lua"))

-- You can add more language snippet files here as needed
-- ls.add_snippets("python", require("snippets.python"))
-- ls.add_snippets("javascript", require("snippets.javascript"))

-- Set snippet configuration
ls.config.setup({
    -- This tells LuaSnip to remember the last snippet selection,
    -- so you can jump back into it even if you move outside the selection
    history = true,

    -- Dynamic snippets update as you type
    updateevents = "TextChanged,TextChangedI",

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use <Tab> to trigger visual selection
    store_selection_keys = "<Tab>",
})
