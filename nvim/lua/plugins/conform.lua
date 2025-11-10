return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			c = { "c_formatter_42" },
			cpp = { "c_formatter_42" }, -- for .h files detected as cpp
		},
		formatters = {
			c_formatter_42 = {
				command = "c_formatter_42",
				args = { "$FILENAME" },
				stdin = false,
			},
		},
	},
}
