local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup({
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  autotag = { enable = true },
  ensure_installed = {
    "c",
    "comment",
    "cpp",
    "css",
    "diff",
    "fish",
    "gitattributes",
    "gitignore",
    "glsl",
    "go",
    "haskell",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "python",
    "regex",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
  },
  auto_install = true,
})
