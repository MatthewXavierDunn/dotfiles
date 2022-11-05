local status, _ = pcall(vim.cmd, "colorscheme ghdark")
if not status then
  print("Colourscheme not found!")
  return
end
