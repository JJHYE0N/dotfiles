local lspconfig = require('lspconfig')

-- function(client, bufnr)
local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- vim.lsp.handlers['textDocument/codeAction'] = function(responses)
  --   -- Select the first item
  --   local _, edit = next(actions[1].edit.changes)
  --   vim.lsp.util.apply_text_edits(edit, vim.api.nvim_get_current_buf())
  -- end
  -- TODO: Change to some kinda this...
  -- vim.diagnostic.config({...})

  -- vim.lsp.handlers["textDocument/definition"] =
  --     function(_, locations, ctx, _)
  --       -- local bufnr = ctx.bufnr
  --       if locations == nil or vim.tbl_isempty(locations) then return end
  --       if #locations > 1 then
  --         -- Returns items
  --         vim.lsp.util.locations_to_items(locations)
  --       else
  --         -- Returns boolean value
  --         vim.lsp.util.jump_to_location(locations[1])
  --         vim.cmd "normal! zz"
  --       end
  --     end
end

local servers = {
  ['clangd'] = require('lsp.clangd'),
  ['cmake'] = require('lsp.cmake'),
  ['bashls'] = require('lsp.bashls'),
  ['pylsp'] = require('lsp.pylsp'),
  ['sumneko_lua'] = require('lsp.lua')
}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
for lsp, setup in pairs(servers) do
  setup.on_attach = on_attach
  setup.capabilities = capabilities
  lspconfig[lsp].setup(setup)
end

-- https://github.com/neovim/neovim/blob/master/runtime/plugin/diagnostic.vim
vim.fn.sign_define('DiagnosticSignError', {
  text = '',
  texthl = 'LspDiagnosticsDefaultError',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text = '',
  texthl = 'LspDiagnosticsDefaultWarning',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignHint', {
  text = '',
  texthl = 'LspDiagnosticsDefaultHint',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text = '',
  texthl = 'LspDiagnosticsDefaultInformation',
  linehl = '',
  numhl = ''
})
