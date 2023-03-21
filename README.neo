-> title

Neovim Grimoire

The Neovim interface to my Grimoire

-> h2

Overview

This is my personal extension for the Telescope^
Neovim plugin. It calls out to a brige process
I have setup (called grimoire_search) that 
in turn queries my files via Meilisearch^. 


-> h2

Usage

I keep the file in an my workshop directory at:


-> code

~/workshop/nvim-grimoire/lua/telescope/_extensions/grimoire.lua


-> p 

I use `lazy`` to load plugins and add mine
into the mix with:

-> code
>> lua
>> filename: ~/.config/nvim/init.lua

require('lazy').setup({
  { dir = "~/workshop/nvim-grimoire" },
  -- etc...
}, {})

pcall(require('telescope').load_extension, 'grimoire')


-> p

The extension makes a call to an external process
for every character. I looked at a half dozen extensions
an none of them worked that way. It took some source
code diving to figure this out. Hopefully posting this
will help if you're interested in trying something 
similar. 


-> footnotes

- <<link | 
  https://github.com/nvim-telescope/telescope.nvim |
  Telescope >> - The highly extendable fuzzy finder
  for Neovim

- <<link |
  https://www.meilisearch.com/
  Meilisearch >> - A super fast, open-source search
  engine written in Rust. 



-> categories
>> Neovim
>> Lua

-> attributes
>> date: 2023-03-21 01:09:04
>> id: 2njouvq5k5g1
>> site: aws
>> type: post
>> status: published

