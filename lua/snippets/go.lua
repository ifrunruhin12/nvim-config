-- Custom Go snippets for competitive programming
-- Place this file at: lua/snippets/go.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

return {
    -- Fast I/O template for competitive programming
    s("fastio", {
        t({
            "package main",
            "",
            "import (",
            '    "bufio"',
            '    "fmt"',
            '    "os"',
            '    "strconv"',
            '    "strings"',
            ")",
            "",
            "var (",
            "    in  = bufio.NewReader(os.Stdin)",
            "    out = bufio.NewWriter(os.Stdout)",
            ")",
            "",
            "func readLine() string {",
            "    line, _ := in.ReadString('\\n')",
            "    return strings.TrimSpace(line)",
            "}",
            "",
            "func readInt() int {",
            "    n, _ := strconv.Atoi(readLine())",
            "    return n",
            "}",
            "",
            "func readInts() []int {",
            "    line := readLine()",
            "    parts := strings.Fields(line)",
            "    nums := make([]int, len(parts))",
            "    for i, s := range parts {",
            "        nums[i], _ = strconv.Atoi(s)",
            "    }",
            "    return nums",
            "}",
            "",
            "func readStrings() []string {",
            "    return strings.Fields(readLine())",
            "}",
            "",
            "func main() {",
            "    defer out.Flush()",
            "    ",
        }),
        i(1, "// code goes here"),
        t({
            "",
            "}",
        }),
    }),

    -- Quick main function
    s("main", {
        t({
            "func main() {",
            "    ",
        }),
        i(1, "// code here"),
        t({
            "",
            "}",
        }),
    }),

    -- Package declaration
    s("pkg", {
        t("package "),
        i(1, "main"),
    }),

    -- Import block
    s("imp", {
        t({
            "import (",
            "    ",
        }),
        i(1, '"fmt"'),
        t({
            "",
            ")",
        }),
    }),

    -- Single import
    s("import", {
        t('import "'),
        i(1, "fmt"),
        t('"'),
    }),

    -- Printf
    s("pf", {
        t('fmt.Printf("'),
        i(1, "%v"),
        t('", '),
        i(2, "value"),
        t(")"),
    }),

    -- Println
    s("pl", {
        t("fmt.Println("),
        i(1, "value"),
        t(")"),
    }),

    -- For loop
    s("for", {
        t("for "),
        i(1, "i := 0; i < 10; i++"),
        t({
            " {",
            "    ",
        }),
        i(2, "// code here"),
        t({
            "",
            "}",
        }),
    }),

    -- Range loop
    s("forr", {
        t("for "),
        i(1, "i"),
        t(", "),
        i(2, "v"),
        t(" := range "),
        i(3, "slice"),
        t({
            " {",
            "    ",
        }),
        i(4, "// code here"),
        t({
            "",
            "}",
        }),
    }),

    -- If statement
    s("if", {
        t("if "),
        i(1, "condition"),
        t({
            " {",
            "    ",
        }),
        i(2, "// code here"),
        t({
            "",
            "}",
        }),
    }),

    -- If-else statement
    s("ife", {
        t("if "),
        i(1, "condition"),
        t({
            " {",
            "    ",
        }),
        i(2, "// if true"),
        t({
            "",
            "} else {",
            "    ",
        }),
        i(3, "// if false"),
        t({
            "",
            "}",
        }),
    }),

    -- Function declaration
    s("func", {
        t("func "),
        i(1, "name"),
        t("("),
        i(2, "params"),
        t(") "),
        i(3, "returnType"),
        t({
            " {",
            "    ",
        }),
        i(4, "// code here"),
        t({
            "",
            "}",
        }),
    }),

    -- Variable declaration
    s("var", {
        t("var "),
        i(1, "name"),
        t(" "),
        i(2, "type"),
        t(" = "),
        i(3, "value"),
    }),

    -- Short variable declaration
    s(":=", {
        i(1, "name"),
        t(" := "),
        i(2, "value"),
    }),

    -- Make slice
    s("makes", {
        t("make([]"),
        i(1, "int"),
        t(", "),
        i(2, "0"),
        t(", "),
        i(3, "10"),
        t(")"),
    }),

    -- Make map
    s("makem", {
        t("make(map["),
        i(1, "string"),
        t("]"),
        i(2, "int"),
        t(")"),
    }),

    -- Error handling
    s("err", {
        t({
            "if err != nil {",
            "    ",
        }),
        i(1, "return err"),
        t({
            "",
            "}",
        }),
    }),

    -- Struct definition
    s("struct", {
        t("type "),
        i(1, "Name"),
        t({
            " struct {",
            "    ",
        }),
        i(2, "Field string"),
        t({
            "",
            "}",
        }),
    }),

    -- Interface definition
    s("interface", {
        t("type "),
        i(1, "Name"),
        t({
            " interface {",
            "    ",
        }),
        i(2, "Method() error"),
        t({
            "",
            "}",
        }),
    }),

    -- Switch statement
    s("switch", {
        t("switch "),
        i(1, "value"),
        t({
            " {",
            "case ",
        }),
        i(2, "condition"),
        t({
            ":",
            "    ",
        }),
        i(3, "// code here"),
        t({
            "",
            "default:",
            "    ",
        }),
        i(4, "// default case"),
        t({
            "",
            "}",
        }),
    }),

    -- Go routine
    s("go", {
        t("go func() {"),
        t({
            "",
            "    ",
        }),
        i(1, "// goroutine code"),
        t({
            "",
            "}()",
        }),
    }),

    -- Channel declaration
    s("chan", {
        t("make(chan "),
        i(1, "int"),
        t(", "),
        i(2, "1"),
        t(")"),
    }),

    -- Select statement
    s("select", {
        t({
            "select {",
            "case ",
        }),
        i(1, "msg := <-ch"),
        t({
            ":",
            "    ",
        }),
        i(2, "// handle message"),
        t({
            "",
            "default:",
            "    ",
        }),
        i(3, "// default case"),
        t({
            "",
            "}",
        }),
    }),

    -- Defer statement
    s("defer", {
        t("defer "),
        i(1, "func()"),
    }),

    -- Method with pointer receiver
    s("method", {
        t("func ("),
        i(1, "r"),
        t(" *"),
        i(2, "Receiver"),
        t(") "),
        i(3, "MethodName"),
        t("("),
        i(4, "params"),
        t(") "),
        i(5, "returnType"),
        t({
            " {",
            "    ",
        }),
        i(6, "// method body"),
        t({
            "",
            "}",
        }),
    }),
}
