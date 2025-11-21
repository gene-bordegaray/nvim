return {
  -- Base dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- UI enhancements
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "▏" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
      require("mini.comment").setup()
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeRefresh" },
    keys = {
      {
        "<leader>e",
        function()
          require("nvim-tree.api").tree.toggle({ focus = true })
        end,
        desc = "Toggle file explorer",
      },
      {
        "<leader>fe",
        function()
          require("nvim-tree.api").tree.find_file({ open = true, focus = true })
        end,
        desc = "Reveal file in explorer",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "json",
        "toml",
        "yaml",
        "rust",
        "query",
        "vim",
        "vimdoc",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Telescope + Harpoon
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep (rg)",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "List buffers",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Workspace diagnostics",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "❯ ",
          path_display = { "smart" },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon add file",
      },
      {
        "<leader>hh",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>h1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon file 1",
      },
      {
        "<leader>h2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon file 2",
      },
      {
        "<leader>h3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon file 3",
      },
      {
        "<leader>h4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon file 4",
      },
      {
        "<leader>hp",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Harpoon previous",
      },
      {
        "<leader>hn",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Harpoon next",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        json = { "jq" },
        toml = { "taplo" },
        ["*"] = { "trim_whitespace" },
      },
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- LSP + tooling
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        update_in_insert = false,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUninstall" },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "jsonls",
        "taplo",
        "yamlls",
      },
      automatic_enable = false,
    },
    config = function(_, opts)
      local mason_lsp = require("mason-lspconfig")
      mason_lsp.setup(opts)

      local lsp = require("config.lsp")
      local function setup(server_name, server_opts)
        server_opts = vim.tbl_deep_extend("force", {
          capabilities = lsp.capabilities(),
          on_attach = lsp.on_attach,
        }, server_opts or {})

        vim.lsp.config(server_name, server_opts)
        vim.lsp.enable(server_name)
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        bashls = {},
        jsonls = {},
        taplo = {},
        yamlls = {},
      }

      for name, server_opts in pairs(servers) do
        setup(name, server_opts)
      end
    end,
  },

  -- Rust specific tooling
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local lsp = require("config.lsp")
      local function codelldb_adapter()
        local ok_registry, mason_registry = pcall(require, "mason-registry")
        if not ok_registry then
          return nil
        end
        if not mason_registry.is_installed("codelldb") then
          return nil
        end

        local mason_root = vim.fn.expand("$MASON")
        if mason_root == "$MASON" then
          mason_root = vim.fn.stdpath("data") .. "/mason"
        end
        local extension_path = table.concat({ mason_root, "packages", "codelldb", "extension" }, "/")
        if vim.fn.isdirectory(extension_path) == 0 then
          return nil
        end

        local codelldb_path = extension_path .. "/adapter/codelldb"
        local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"

        local ok_adapter, adapter = pcall(function()
          return require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
        end)

        if ok_adapter then
          return adapter
        end

        return nil
      end

      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = lsp.on_attach,
          capabilities = lsp.capabilities(),
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
              },
              check = {
                command = "clippy",
              },
              inlayHints = {
                bindingModeHints = { enable = true },
                closureReturnTypeHints = { enable = true },
                lifetimeElisionHints = { enable = true },
                implicitDrops = { enable = true },
              },
            },
          },
        },
        dap = (function()
          local adapter = codelldb_adapter()
          if adapter then
            return { adapter = adapter }
          end
          return {}
        end)(),
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufReadPost Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>cv",
        function()
          require("crates").show_versions_popup()
        end,
        desc = "Crates versions",
      },
      {
        "<leader>cf",
        function()
          require("crates").show_features_popup()
        end,
        desc = "Crates features",
      },
      {
        "<leader>cu",
        function()
          require("crates").upgrade_crate()
        end,
        desc = "Upgrade crate",
      },
    },
    config = function()
      require("crates").setup({
        completion = { cmp = { enabled = true } },
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    ft = { "rust" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest file",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest nearest",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Neotest output",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust")({
            args = { "--nocapture" },
          }),
        },
      })
    end,
  },
}

