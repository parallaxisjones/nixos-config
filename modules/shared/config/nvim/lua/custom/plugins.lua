local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {},
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },

  -- Avante.nvim with OpenAI + MCP integration
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      -- mode = "agentic",
      -- cursor_planning_mode = true,
      provider = "openai",
      providers = {
        openai = {
          model = "gpt-4o-mini",
          timeout = 60000,
          extra_request_body = {
            temperature = 0.0,
            max_tokens = 8192,
            top_p = 1.0,
            frequency_penalty = 0.0,
            presence_penalty = 0.0,
          },
        },
      },
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
    config = function(_, opts)
      require("avante").setup(opts)
    end,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- MCP Hub (mcp-hub) configuration per official docs
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    config = function()
      local config_path = vim.fn.expand("~/.config/mcphub/servers.json")
      local mcp_cmd     = vim.fn.exepath("mcp-hub")
      if mcp_cmd == "" then
        error("[mcphub.nvim] mcp-hub not found; please install via `npm install -g mcp-hub@latest` or adjust cmd manually.")
      end

      require("mcphub").setup({
        -- core binary options
        config             = config_path,
        port               = 37373,
        shutdown_delay     = 60 * 10 * 1000,   -- 10 minutes
        use_bundled_binary = false,
        mcp_request_timeout = 60000,

        -- chat-plugin integration
        auto_approve           = false,
        auto_toggle_mcp_servers = true,
        extensions = {
          avante = {
            enabled             = true,
            make_slash_commands = true,
          },
        },

        -- plugin-specific options
        native_servers = {},
        ui = {
          window = {
            width    = 0.85,
            height   = 0.85,
            align    = "center",
            relative = "editor",
            zindex   = 50,
            border   = "rounded",
          },
          wo = {
            winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
          },
        },

        -- lifecycle hooks
        on_ready = function(hub)
          vim.notify("MCP Hub ready on port " .. hub.port, vim.log.levels.INFO)
        end,
        on_error = function(err)
          vim.notify("MCP Hub error: " .. err, vim.log.levels.ERROR)
        end,

        -- logging
        log = {
          level     = vim.log.levels.WARN,
          to_file   = false,
          file_path = nil,
          prefix    = "MCPHub",
        },

        -- use the global binary
        cmd = mcp_cmd,
        -- plugin will auto-generate args from the above options
      })
    end,
  },

  {
    "kevinhwang91/promise-async",
    lazy = true,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn     = "1"
      vim.o.foldlevel      = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable     = true
      vim.o.foldmethod     = "expr"
      vim.o.foldexpr       = "nvim_treesitter#foldexpr()"

      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds,  { desc = "UFO: open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: close all folds" })
    end,
  },
}

return plugins
