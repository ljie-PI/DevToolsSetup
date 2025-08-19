local M = {}

M.options = {
	events = { "BufWritePost", "BufReadPost", "InsertLeave" },
	linters_by_ft = {
		bash = { "bash" },
		javascript = { "eslint_d" },
		lua = { "luacheck" },
		python = { "pylint" },
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
	},
}

M.setup = function(_, opts)
	vim.api.nvim_create_autocmd(opts.events, {
		group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
		callback = function()
			require("lint").try_lint()
		end,
	})
end

return M
