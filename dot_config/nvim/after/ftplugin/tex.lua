-- Set shift width and tabstop to match one level of indent
vim.bo.shiftwidth = 4   -- or 4, depending on how wide you want one tab
vim.bo.tabstop = 4 -- width of a tab character
vim.bo.softtabstop = 4 -- how many spaces a <Tab> feels like when editing
vim.bo.expandtab = false  -- use spaces, or set to false for real tabs
vim.bo.smartindent = false  -- disable smart indent
vim.bo.autoindent = true    -- keep the same indent as the previous line
vim.bo.indentexpr = '' -- disable filetype-specific indentexpr
