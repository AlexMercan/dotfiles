local ls = require("luasnip")
local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node

local fmta = require("luasnip.extras.fmt").fmta

-- returns 2 lists, first is regular snippets, second it autosnippets
return {

	s(
		"gwt",
		fmta(
			[[
@Test
void given<g>_when<w>_then<t>() {
    // given
    <finish>
    // when

    // then
}
]],
			{
				g = i(1, ""),
				w = i(2, ""),
				t = i(3, ""),
				finish = i(0, ""),
			}
		)
	),

	s(
		"psfs",
		fmta(
			[[
<modifier> static final String <name> = "<value>";
]],
			{
				modifier = c(1, { t("private"), t("public") }),
				name = i(2, "NAME"),
				value = i(3, "value"),
			}
		)
	),
	s(
		"pclass",
		fmta(
			[[
<annotations>
public class <classname> {
    <finish>
}
]],
			{
				annotations = i(1, ""),
				classname = f(function()
					return vim.fn.expand("%:t:r")
				end),
				finish = i(2, ""),
			}
		)
	),
}, {}
