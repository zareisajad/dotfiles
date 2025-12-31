local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-telescope/telescope.nvim",

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup({
    hijack_netrw = true,
    update_focused_file = { enable = true, update_cwd = true },
    view = { width = 30, side = "left" },
    renderer = {
      icons = {
        show = { file = false, folder = false, folder_arrow = false, git = false },
        glyphs = {
          default = "", symlink = "",
          folder = { default = "", open = "", empty = "", empty_open = "", symlink = "", symlink_open = "" },
          git = { unstaged = "", staged = "", unmerged = "", renamed = "", untracked = "", deleted = "", ignored = "" },
        },
      },
    },
    actions = {
      open_file = {
        resize_window = true,
        window_picker = { enable = false },
      },
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')
      api.config.mappings.default_on_attach(bufnr)
      local function opts(desc)
        return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open: Current Window'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('Open: Current Window'))
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
    end,
  })

   end,
  },

  -- LSP / Autocomplete
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",

  -- Auto close tags
  "windwp/nvim-ts-autotag",



  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- gruvbox theme
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
})

-- Treesitter config
require('nvim-treesitter.configs').setup({
  ensure_installed = { "python", "javascript", "typescript", "tsx", "html", "css", "lua" },
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
})

-- Mason + LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "ts_ls", "html", "cssls" },
})

-- Suppress deprecated warning from lspconfig framework
vim.notify = function(...) end

local on_attach = function(_, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, lsp in ipairs({ "pyright", "ts_ls", "html", "cssls" }) do
  require("lspconfig")[lsp].setup({ on_attach = on_attach, capabilities = capabilities })
end

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
  }),
  sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" }, { name = "luasnip" } },
})

-- Auto-close tags
require('nvim-ts-autotag').setup()

-- Integrate autopairs with nvim-cmp
local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true })

vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")



