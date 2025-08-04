-- lua/config/formatting.lua

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Prettier (Mason'dan kurulu olmalı)
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "javascript", "typescript", "typescriptreact", "json", "css", "html", "markdown" },
        }),
      },
    })

    -- Manuel format kısayolu
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "Format with Prettier/null-ls" })

    -- Kaydederken otomatik format
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.css", "*.html", "*.md" },
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}

