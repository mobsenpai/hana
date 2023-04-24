local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- Lua
  b.formatting.stylua,

  -- Nix
  b.formatting.alejandra,

  -- JS
  b.formatting.prettier,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
