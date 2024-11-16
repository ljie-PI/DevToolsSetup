local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    show_tab_indicators = true,
    always_show_bufferline = true,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
  }
}
