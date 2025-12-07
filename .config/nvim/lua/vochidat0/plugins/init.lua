vim.filetype.add({
  extension = {
    helm = "helm",
    tf = "terraform",
    tfvars = "terraform",
    tfstate = "json",
  },
  filename = {
    ["Chart.yaml"] = "yaml",
    ["values.yaml"] = "yaml",
    [".terraform.lock.hcl"] = "hcl",
    ["terraform.tfvars"] = "terraform",
  },
  pattern = {
    -- helm pattern
    [".*/templates/.*%.yaml"] = function(path, buf)
      -- Check if we are inside a chart by looking for Chart.yaml up the tree
      if vim.fs.find("Chart.yaml", { path = path, upward = true })[1] then
        return "helm"
      end
      return "yaml"
    end,
    [".*/templates/.*%.tpl"] = "helm",

    -- ansible patterns
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*playbook.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/defaults/.*%.ya?ml"] = "yaml.ansible",
    [".*/ansible/.*%.ya?ml"] = "yaml.ansible",
    [".*/inventory/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",

    -- TERRAFORM PATTERNS
    ["%.tf"] = "terraform",
    ["%.tfvars"] = "terraform",
    ["%.tfstate"] = "json",
    ["%.tfstate%.backup"] = "json",
  },
})

return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
}
