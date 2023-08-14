local status, statuscol = pcall(require, "statuscol")

if not status then
  return
end

local builtin = require("statuscol.builtin")

statuscol.setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    { text = { " %s" }, click = "v:lua.ScSa" },
    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
  },
})
