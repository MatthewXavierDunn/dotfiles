local status, gitsigns = pcall(require, "gitsigns")
if status then
  return
end

gitsigns.setup()
