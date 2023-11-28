-- Based off of `kickstart.nvim` - https://github.com/nvim-lua/kickstart.nvim.

-- Set local leader to `<Space>`.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap `lazy.nvim`.
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Packages.
require("lazy").setup({

  -- `:G` - Git actions.
  "tpope/vim-fugitive",

  -- `:GBrowse` - Open GitHub urls.
  -- `<C-X><C-O>` - GitHub issues, issue URLs, and collaborators omni-complete.
  "tpope/vim-rhubarb",

  -- Detect tabstop and shiftwidth automatically.
  "tpope/vim-sleuth",

  { -- LSP Configuration & Plugins.
    "neovim/nvim-lspconfig",
    dependencies = {
      { -- Automatically install LSPs to stdpath for neovim.
        "williamboman/mason.nvim",
        config = true
      },

      "williamboman/mason-lspconfig.nvim",

      { -- Useful status updates for LSP.
        "j-hui/fidget.nvim",
        opts = {}
      },

      -- Additional lua configuration.
      "folke/neodev.nvim",
    },
  },

  { -- Allow non-lsp's to hook into the LSP client.
    "jose-elias-alvarez/null-ls.nvim",
    opts = {},
  },

  { -- Bridge the gap between `mason` and `null-ls`.
    "jay-babu/mason-null-ls.nvim",
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {},
  },

  { -- Autocompletion.
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  { -- Show pending key binds.
    "folke/which-key.nvim",
    opts = {}
  },

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes.
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "" },
        change = { text = "󰦓" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "󰦓" },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  { -- Mocha theme :)
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  { -- Set lualine as statusline.
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  -- Fuzzy Finder (files, lsp, etc).
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
  },

  { -- Highlight, edit, and navigate code.
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  { -- Surround actions.
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  { -- Autopairing of brackets, etc.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  { -- Super-power `leap.nvim` actions.
    "ggandor/flit.nvim",
    opts = { labeled_modes = "nx" },
  },

  { -- Better `f` and `t` experience.
    "ggandor/leap.nvim",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        desc = "Leap forward to"
      },
      {
        "S",
        mode = { "n", "x", "o" },
        desc = "Leap backward to"
      },
      {
        "gs",
        mode = { "n", "x", "o" },
        desc = "Leap from windows"
      },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  { -- `gS` - Split long lines to correctly formatted multiline equivalent, and back.
    "echasnovski/mini.splitjoin",
    opts = {},
  },

  { -- `ga` - Align selection.
    "echasnovski/mini.align",
    opts = {},
  },

  { -- `[`, `]` - Navigate between targets.
    "echasnovski/mini.bracketed",
    opts = {},
  },

  { -- `<Alt>[hjkl]` - Move around selected text.
    "echasnovski/mini.move",
    opts = {},
  },

  { -- `gcc` - Toggle comments.
    "echasnovski/mini.comment",
    opts = {},
  },

  { -- `Idris2` lsp support.
    "ShinKage/idris2-nvim",
    dependencies = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" },
    opts = {},
  },

  { -- Allow transparent navigation between `tmux` panes.
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        }
      });
    end
  },

  { -- Multi-cursor magic!
    "mg979/vim-visual-multi"
  },

  { -- Better buffer and mark experience + Terminal.
    "ThePrimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local term = require("harpoon.term")
      local cmd_ui = require("harpoon.cmd-ui")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "[M]ark [A]dd file" })
      vim.keymap.set("n", "<leader>cl", cmd_ui.toggle_quick_menu, { desc = "Toggle [C]ommands [L]ist" })
      vim.keymap.set("n", "<leader>ct", function() term.gotoTerminal(1) end, { desc = "Open [C]ommand [T]erminal" })
      vim.keymap.set("n", "<leader>ml", ui.toggle_quick_menu, { desc = "Toggle [M]arks [L]ist" })
      vim.keymap.set("n", "<leader>mn", ui.nav_next, { desc = "[M]ark [N]ext file" })
      vim.keymap.set("n", "<leader>mp", ui.nav_prev, { desc = "[M]ark [P]revious file" })
      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Go to mark [1]" })
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Go to mark [2]" })
      vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Go to mark [3]" })
      vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Go to mark [4]" })
      vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, { desc = "Go to mark [5]" })
      vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end, { desc = "Go to mark [6]" })
      vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end, { desc = "Go to mark [7]" })
      vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end, { desc = "Go to mark [8]" })
      vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end, { desc = "Go to mark [9]" })
      vim.keymap.set("n", "<leader>0", function() ui.nav_file(10) end, { desc = "Go to mark [0]" })
    end
  },

  { -- Single window file browser with cross directory editing.
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      oil.setup()
      vim.keymap.set("n", "<leader>nt", oil.toggle_float, { desc = "Open file browser" })
    end
  },

  { -- `typst` lsp support.
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  }

}, {})

-- Set highlight on search.
vim.o.hlsearch = false

-- Set relative line numbers.
vim.o.relativenumber = true

-- Enable mouse mode.
vim.o.mouse = "a"

-- Enable break indent.
vim.o.breakindent = true

-- Save undo history.
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
vim.wo.signcolumn = "yes"

-- Decrease update time.
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience.
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this.
vim.o.termguicolors = true

-- set tab width to four spaces.
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience.
-- See `:help vim.keymap.set()`.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Make moving up and down center the line visually.
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")

-- Expected navigation in terminal mode.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-o>", "<C-\\><C-n><C-o>")
vim.keymap.set("t", "<C-i>", "<C-\\><C-n><C-i>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`.
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed.
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`.
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "[F]ind [G]it" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fw", require('telescope.builtin').grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").live_grep, { desc = "[F]ind by g[R]ep" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup {
  -- Add languages to be installed here that you want installed for treesitter.
  ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}

-- Diagnostic keymaps.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  typst_lsp = {
    exportPdf = "onType",
  },
}

-- Setup neovim lua configuration.
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed.
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    local lspconfig = require("lspconfig")
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git") or vim.fn.getcwd()
    }
  end,
}

-- nvim-cmp setup
local cmp = require "cmp"
local luasnip = require "luasnip"

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
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
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

