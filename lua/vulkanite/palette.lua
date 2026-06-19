local palette = {
  base00 = "#0f1416",
  base01 = "#0f1416",
  base02 = "#5c6370",
  base03 = "#5c6370",
  base04 = "#abb2bf",
  base05 = "#f8fdff",
  base06 = "#f8fdff",
  base07 = "#f8fdff",
  base08 = "#e05f64",
  base09 = "#e03f32",
  base0A = "#8fe0fa",
  base0B = "#8be086",
  base0C = "#567e96",
  base0D = "#8fe0fa",
  base0E = "#37868b",
  base0F = "#37868b",
  comment = "#8e969a",
  orange = "#e0af73",
  purple = "#7b78aa",
}

local aliases = {
  bg = palette.base00,
  bg_alt = palette.base01,
  bg_float = palette.base01,
  fg = palette.base05,
  fg_dim = palette.base04,
  comment = palette.comment,
  gutter = palette.base03,
  red = palette.base09,
  value = palette.base08,
  orange = palette.orange,
  yellow = palette.base0A,
  green = palette.base0B,
  cyan = palette.base0C,
  blue = palette.base0D,
  teal = palette.base0E,
  purple = palette.purple,
}

local M = {}

function M.get()
  return vim.tbl_deep_extend("force", vim.deepcopy(palette), aliases)
end

return M
