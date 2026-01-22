return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Hàm setup keymaps giữ nguyên logic cũ của bạn
      local function setup_keymaps(bufnr)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end
        map("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover")
        map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
      end

      -- Attach handler
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          setup_keymaps(args.buf)
        end,
      })

      -- ════════════════════════════════════════════════════════════════════
      -- Setup các LSP trực tiếp (Vì chúng đã có sẵn trong PATH nhờ Nix)
      -- ════════════════════════════════════════════════════════════════════

      -- Servers chạy cấu hình mặc định
      local servers = {
        "gopls",
        "zls",
        "rust_analyzer",
        "pyright",
        "html",
        "cssls",
        "jsonls",
        "bashls",
        "nil_ls",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
      end

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        settings = {
          completions = { completeFunctionCalls = false },
        },
      })
    end,
  },
}
