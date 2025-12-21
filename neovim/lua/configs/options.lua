local options = {
  -- basic settings
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  mouse = "",                              -- disable mouse
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  number = true,                           -- set numbered lines
  wrap = true,                            -- display lines as one long line, or true to wrap within screen
  fileencoding = "utf-8",                  -- the encoding written to a file
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  cursorline = true,                       -- highlight the current line

  -- search settings
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- smart case

  -- indentation
  smartindent = true,                      -- make indenting smarter again
  swapfile = false,                        -- creates a swapfile
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- number of spaces for a tab

  -- others
  shortmess = vim.o.shortmess .. "c"       -- suppress completion menu messages
 }

for k, v in pairs(options) do
  vim.opt[k] = v
end
