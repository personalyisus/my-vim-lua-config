vim.pack.add({
  { src = gh("nvimdev/dashboard-nvim") },
})

-- Generated on: http://www.patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20
-- Using the font: ANSI Shadow

    local logo = [[
    
██████╗ ███████╗██████╗ ███████╗ ██████╗ ███╗   ██╗ █████╗ ██╗     
██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗████╗  ██║██╔══██╗██║     
██████╔╝█████╗  ██████╔╝███████╗██║   ██║██╔██╗ ██║███████║██║     
██╔═══╝ ██╔══╝  ██╔══██╗╚════██║██║   ██║██║╚██╗██║██╔══██║██║     
██║     ███████╗██║  ██║███████║╚██████╔╝██║ ╚████║██║  ██║███████╗
╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
                                                                   
            ██╗   ██╗██╗███████╗██╗   ██╗███████╗              
            ╚██╗ ██╔╝██║██╔════╝██║   ██║██╔════╝              
             ╚████╔╝ ██║███████╗██║   ██║███████╗              
              ╚██╔╝  ██║╚════██║██║   ██║╚════██║              
               ██║   ██║███████║╚██████╔╝███████║              
               ╚═╝   ╚═╝╚══════╝ ╚═════╝ ╚══════╝              
                                                                   
    ]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

-- stylua: ignore
local center = {
  { action = "FzfLua files",                                     desc = " Find file",       icon = " ", key = "f" },
  { action = "ene | startinsert",                                desc = " New file",        icon = " ", key = "n" },
  { action = "FzfLua oldfiles",                                  desc = " Recent files",    icon = " ", key = "r" },
  { action = "FzfLua live_grep",                                 desc = " Find text",       icon = " ", key = "t" },
  { action = function()
      vim.cmd('cd ~/.config/nvim')
      vim.cmd("edit ~/.config/nvim/init.lua")
    end,                                                         desc = " Config",          icon = " ", key = "c" },
  { action = "qa",                                               desc = " Quit",            icon = " ", key = "q" },
}

for _, button in ipairs(center) do
  button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
end

require("dashboard").setup({
  theme = "doom",
  hide = {
    -- this is taken care of by lualine
    -- enabling this messes up the actual laststatus setting after loading a file
    statusline = false,
  },
  config = {
    header = vim.split(logo, "\n"),
    center = center,
  },
})
