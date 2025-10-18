local build_cmd = nil
for _, cmd in ipairs({ "make", "cmake" }) do
  if vim.fn.executable(cmd) == 1 then
    build_cmd = cmd
    break
  end
end

local function telescope_opts()
  local actions = require("telescope.actions")
  return {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      -- open files in the first window that is an actual file.
      -- use the current window if no other window is available.
      get_selection_window = function()
        local wins = vim.api.nvim_list_wins()
        table.insert(wins, 1, vim.api.nvim_get_current_win())
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buftype == "" then
            return win
          end
        end
        return 0
      end,
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-b>"] = actions.preview_scrolling_up,

          ["<C-h>"] = "which_key",
        },
        n = {
          ["q"] = actions.close,
        },
      },
      file_ignore_patterns = {
        ".project",
        ".tags",
        "build/",
        "out/",
        "target/",
        "node_modules/",
        "data/",
        "log/",
        "logs/",
      },
    },
    extensions = {
      ["fzf"] = {
        case_mode = "smart_case", ---@type "smart_case"|"ignore_case"|"respect_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  }
end

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = (build_cmd ~= "cmake") and "make"
      or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build",
    enabled = build_cmd ~= nil,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = telescope_opts,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
