-> title

Neovim Grimoire

The Neovim interface to my Grimoire

-> h2

Development

-> h3 

File path:

-> code

/workshop/nvim-grimoire/lua/telescope/_extensions

-> h3

In the inti.lua file (using lazy.nvim):

-> code
-> lua
-> filename: ~/.config/nvim/init.lua

require('lazy').setup({

  { dir = "~/Desktop/extension_name" },
  
  -- other plugins
  
}, {})


pcall(require('telescope').load_extension, 'extension_name')




