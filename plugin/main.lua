local parsers = require "nvim-treesitter.parsers"


local function inject()
    local lang_tree = parsers.get_parser(0)
    local lang = lang_tree:lang()

    local query = ""

    if lang == "typescript" then
        local all_langs = { 'rust', 'lua', 'python' }
        for _, known_lang in ipairs(all_langs) do
            query = query .. string.format([[
(
    (comment) @_comment (#eq? @_comment "/*%s*/")
    (
        (template_string) @%s
        (#offset! @%s 0 1 0 -1)
    )
)
(
    (comment) @_comment (#eq? @_comment "/*%s*/")
    (expression_statement
        (template_string) @%s
        (#offset! @%s 0 1 0 -1)
    )
)
]]           , known_lang, known_lang, known_lang, known_lang, known_lang, known_lang)

        end
    elseif lang == "rust" then
        local all_langs = { 'typescript', 'lua', 'python' }
        for _, known_lang in ipairs(all_langs) do
            query = query .. string.format([[
(
    (block_comment) @_comment (#eq? @_comment "/*%s*/")
    (
        (raw_string_literal) @%s
        (#offset! @%s 0 3 0 -3)
    )
)
(
    (block_comment) @_comment (#eq? @_comment "/*%s*/")
    (expression_statement
        (raw_string_literal) @%s
        (#offset! @%s 0 3 0 -3)
    )
)
]]           , known_lang, known_lang, known_lang, known_lang, known_lang, known_lang)
        end
    else
        print("Please PR this language!")
    end

    require("vim.treesitter.query").set_query(lang, "injections", query)
end

vim.api.nvim_create_user_command("Inject", inject, {})
