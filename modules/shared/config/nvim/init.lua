require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lockfile_path = vim.fn.stdpath "state" .. "/lazy-lock.json"
vim.g.lazy_lockfile = lockfile_path
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr   = "nvim_treesitter#foldexpr()"  -- UFO will override this; it just ensures expr‐mode is on
-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"
