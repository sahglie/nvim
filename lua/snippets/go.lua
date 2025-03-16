local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  -- Test function snippet
  s("tt", fmt([[
func Test{}(t *testing.T) {{
	tests := []struct {{
		name     string
		input    {}
		expected {}
	}}{{
		{{
			name:     "{}",
			input:    {},
			expected: {},
		}},
		// Add more test cases here
	}}

	for _, tt := range tests {{
		t.Run(tt.name, func(t *testing.T) {{
			result, err := {}(tt.input)
			
			if err != nil {{
				t.Errorf("{} unexpected error: %v", err)
			}}
			
			if result != tt.expected {{
				t.Errorf("{} = %v, want %v", result, tt.expected)
			}}
		}})
	}}
}}
]], {
    i(1, "FunctionName"),
    i(2, "string"),
    i(3, "any"),
    i(4, "test case"),
    i(5, "\"example\""),
    i(6, "\"expected\""),
    i(7, "FunctionName"),
    i(8, "FunctionName()"),
    i(9, "FunctionName()"),
  })),
}

return snippets
