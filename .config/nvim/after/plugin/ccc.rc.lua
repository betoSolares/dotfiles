local status, ccc = pcall(require, "ccc")

if not status then
  return
end

ccc.setup({})
