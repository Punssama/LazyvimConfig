--terminal
--change vim shell to pwsh
-- Check if 'pwsh' is executable and set the shell accordingly
if vim.fn.executable("pwsh") == 1 then
  vim.o.shell = "pwsh"
else
  vim.o.shell = "powershell"
end

-- Setting shell command flags
vim.o.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
-- Setting shell redirection
vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
vim.o.shellquote = ""
vim.o.shellxquote = ""

--fzf
require("telescope").load_extension("file_browser")
--incline
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")
require("incline").setup({
  window = {
    padding = 0,
    margin = { horizontal = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    if filename == "" then
      filename = "[No Name]"
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local modified = vim.bo[props.buf].modified
    return {
      ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
      " ",
      { filename, gui = modified and "bold,italic" or "bold" },
      " ",
      guibg = "#24272E",
    }
  end,
})

--comment nvim
require("Comment").setup()

--whichkey
local whichkey = require("which-key")

whichkey.add({
  {
    "<leader>t",
    desc = "Terminal",
    mode = "n",
  },
  {
    "<leader>th",
    "<cmd>ToggleTerm direction=horizontal<cr>",
    desc = "Open terminal horizontally",
    mode = "n",
  },
  {
    "<leader>tf",
    "<cmd>ToggleTerm direction=float<cr>",
    desc = "Open floating terminal",
    mode = "n",
  },
  {
    "<leader>/",
    "<Plug>(comment_toggle_linewise_visual)",
    desc = "Comment toggle (linewise_visual)",
    mode = { "n", "v" },
  },
  {
    "<leader>fa",
    "<cmd>Telescope file_browser<cr>",
    desc = "file browser",
    mode = "n",
  },
})
-------

--snippet
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-K>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
    },
  },
}
