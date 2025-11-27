return {
  "hrsh7th/cmp-nvim-lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- for ansible
    vim.filetype.add({
      pattern = {
        [".*playbook.*%.ya?ml"] = "yaml.ansible",
        [".*roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
      },
    })

    local lint_ok, lint = pcall(require, "lint")
    if lint_ok then
      lint.linters.pylint.cmd = "python"
      lint.linters.pylint.args = { "-m", "pylint", "-f", "json" }
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    local servers = {
      lua_ls = {
        filetypes = { "lua" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
      ts_ls = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
      html = {
        filetypes = { "html" },
      },
      cssls = {
        filetypes = { "css", "scss", "less" },
      },
      tailwindcss = {
        filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
      },
      emmet_ls = {
        filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
      },
      pyright = {
        filetypes = { "python" },
      },
      eslint = {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
      tflint = {
        filetypes = { "terraform", "tf" },
        -- root dir is the path that contains wither .terraform or .git folder. Search up to the parrent untill find either folder
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find({ ".terraform", ".git" }, { upward = true })[1])
        end,
      },
      ansiblels = {
        filetypes = { "yaml", "yaml.ansible" },
        settings = {
          ansible = {
            ansible = {
              path = "ansible",
            },
            executionEnvironment = {
              enabled = false,
            },
            python = {
              interpreterPath = "python3",
            },
            validation = {
              enabled = true,
              lint = {
                enabled = true,
                path = "ansible-lint",
              },
            },
          },
        },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("ansible.cfg", ".ansible-lint", "playbook.yml", "playbooks/")(fname)
            or util.root_pattern(".git")(fname)
        end,
      },
    }

    -- Apply configurations and enable servers
    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
