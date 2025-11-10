return {
	"mfussenegger/nvim-lint",
	opts = {
		linters_by_ft = {
			c = { "norminette" },
		},
	},
	config = function(_, opts)
		local lint = require("lint")

		-- Configure norminette linter
		lint.linters.norminette = {
			cmd = "norminette",
			stdin = false,
			args = {},
			stream = "stdout",
			ignore_exitcode = true,
			parser = function(output)
				local diagnostics = {}
				for line in output:gmatch("[^\r\n]+") do
					local row, col, msg = line:match("%(line:%s*(%d+),%s*col:%s*(%d+)%):%s*(.+)")
					if row and col and msg then
						table.insert(diagnostics, {
							lnum = tonumber(row) - 1,
							col = tonumber(col) - 1,
							message = msg,
							severity = vim.diagnostic.severity.ERROR,
							source = "norminette",
						})
					end
				end
				return diagnostics
			end,
		}

		lint.linters_by_ft = opts.linters_by_ft

		-- Auto-lint on save
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
