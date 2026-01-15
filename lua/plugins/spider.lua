
return {
    "chrisgrieser/nvim-spider",
    keys = {
        { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
        { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
        { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
    },
    opts = {
        skipInsignificantPunctuation = false,
        subwordMovement = true,
        consistentOperatorPending = false, -- see the README for details
        customPatterns = {},        -- see the README for details
    }
}
