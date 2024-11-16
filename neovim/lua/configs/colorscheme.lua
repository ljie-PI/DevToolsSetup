vim.cmd [[
try
  set background=dark
  colorscheme tokyonight-storm
catch /^Vim\%((\a\+)\)\=:E185/
  set background=dark
  colorscheme default
endtry
]]
