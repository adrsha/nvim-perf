return {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
        require 'git-conflict'.setup {
            disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen',     -- command or function to open the conflicts list
            highlights = {             -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        }
    end
}
