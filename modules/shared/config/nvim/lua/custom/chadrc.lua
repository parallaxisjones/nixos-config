---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "github_light",
  theme_toggle = { "github_light", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- ──────────────────────────────────────────────────────────────────────────────
-- Force Lazy.nvim’s lockfile into ~/.local/state/nvim/lazy-lock.json:
local default_lazy = require("plugins.configs.lazy_nvim")
default_lazy.lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json"
M.lazy_nvim = default_lazy
-- ──────────────────────────────────────────────────────────────────────────────
-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
