-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	    -- add your plugins here
	    {'nvim-telescope/telescope.nvim'},
	    {"williamboman/mason.nvim"},
	    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	    {'neovim/nvim-lspconfig'},
	    {'hrsh7th/cmp-nvim-lsp'},
	    {'hrsh7th/nvim-cmp'},
	    {'L3MON4D3/LuaSnip'},
	    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	    {'mbbill/undotree'},
	    {'jpalardy/vim-slime'},
	    {'aserowy/tmux.nvim', config=function() return require("tmux").setup() end}
    },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- keymappings
-- vim keymappings
vim.keymap.set('n', '<Leader>ex', function() vim.cmd("Ex") end)

-- telescope keymappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>cs', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>rr', builtin.registers, {})
vim.keymap.set('n', '<leader>zz', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>hk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})

-- luasnip
-- TODO finish configuring
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
require("luasnip.loaders.from_vscode").lazy_load()

-- Mason
require("mason").setup()

-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

lsp_zero.preset("recommended")
require('lspconfig').lua_ls.setup({})

-- undo tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- writing features: spellcheck etc
vim.keymap.set('n', '<leader>r', ':setlocal spell! spelllang=en_us<CR>',{noremap = true})

--slime config
vim.g.slime_target = "tmux"
