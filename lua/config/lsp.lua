-- lua/config/lsp.lua

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",       -- Python
          "ts_ls",      -- JavaScript / TypeScript
          "lua_ls",        -- Lua
          "rust_analyzer", -- Rust
        },
        automatic_installation = true,
      })

      -- 🔹 Kurulu sunucuları alıp döngü ile başlatıyoruz
      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        if server == "lua_ls" then
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        else
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end
      end
    end,
  },
}

