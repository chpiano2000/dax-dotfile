return {
  filetypes = { "helm" },
  settings = {
    ["helm-ls"] = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
  root_markers = {
    ".helmignore",
    "Chart.yaml",
    "values.yaml",
  },
}
