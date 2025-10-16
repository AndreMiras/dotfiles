-- ~/.config/nvim/lua/options.lua
require "nvchad.options"

local o = vim.o

-- https://github.com/NvChad/NvChad/discussions/1238
-- Also on Arch wl-clipboard if on Wayland or xclip if on X11
o.clipboard = ""
