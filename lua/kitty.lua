local kitty_id = vim.env.KITTY_WINDOW_ID
local NORMAL_PADDING = 10 -- keep in sync with window_padding_width
local NVIM_PADDING = 0

-- Do nothing outside kitty or when the kitten binary is missing.
if not kitty_id or vim.fn.executable("kitten") ~= 1 then
  return
end

local function set_padding(pad)
  vim.fn.system({
    "kitten", "@", "set-spacing",
    "--match", "id:" .. kitty_id,
    "padding=" .. pad,
  })
end

local group = vim.api.nvim_create_augroup("KittyPadding", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  group = group,
  callback = function() set_padding(NVIM_PADDING) end,
})

vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
  group = group,
  callback = function() set_padding(NORMAL_PADDING) end,
})
