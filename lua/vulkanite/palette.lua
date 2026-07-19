local palette = {
  dark_black = "#0f1416",
  soft_black = "#151b1e",
  slate_grey = "#5c6370",
  comment_grey = "#8e969a",
  light_grey = "#abb2bf",
  pale_grey = "#dce5e9",
  coral_red = "#e05f64",
  vivid_red = "#e03f32",
  yellow = "#e0af68",
  sky_blue = "#76c7e3",
  bright_green = "#8be086",
  muted_blue = "#567e96",
  bright_blue = "#8fe0fa",
  dark_teal = "#37868b",
  bright_teal = "#4fa3a6",
  purple = "#9083B9",
}

palette.base16 = {
  base00 = palette.dark_black,
  base01 = palette.soft_black,
  base02 = palette.slate_grey,
  base03 = palette.comment_grey,
  base04 = palette.light_grey,
  base05 = palette.pale_grey,
  base06 = palette.pale_grey,
  base07 = palette.pale_grey,
  base08 = palette.coral_red,
  base09 = palette.vivid_red,
  base0A = palette.sky_blue,
  base0B = palette.bright_green,
  base0C = palette.muted_blue,
  base0D = palette.bright_blue,
  base0E = palette.dark_teal,
  base0F = palette.bright_teal,
}

local M = {}

function M.get()
  return vim.deepcopy(palette)
end

return M
