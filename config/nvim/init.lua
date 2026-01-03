-- Decide which config to use based on whether this is VScode embedded Neovim
if vim.g.vscode then
    -- VSCode embedded Neovim
    require('vscode-init')
else
    -- Ordinary Neovim
    require('vanilla-init')
end