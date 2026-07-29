local M = {}

M.url = "https://github.com/akinsho/bufferline.nvim"

function M.get(colors, opts)
  return {
    -- Bufferline selected buffer name.
    BufferLineBufferSelected = { fg = colors.accent_secondary, bold = true, italic = true },
  }
end

return M
