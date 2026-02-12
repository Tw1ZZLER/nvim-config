return {
  "snacks.nvim",
  event = "VimEnter",
  after = function()
    require("snacks").setup {
      animate = { enabled = true },
      notifier = { enabled = true },
      input = { enabled = true },
      quickfile = { enabled = true },
      picker = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      statuscolumn = { enabled = true },
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
        },
        preset = {
          header = [[
♠️       ██████████            ██████████     ♥️
       ██                                ██     
    ███         ███████████████████             
           █████████████       █████████        
       ███████         ██    ██        ████     
    ███  ██            ███  ██            ██    
   ██  ██     ███       ██  █      ███    ██    
  ██  ██      ███      ██   ██     ███    █ █   
 ██   █               ██     ██          ██ █   
 █    ██            ███       █████     ██   █  
 █     █████   ██████      █      ██████    ██  
 █         █████           ██               █   
 ██                         ███            ██   
  █           ███       ██████           ███    
  ██             ████████             ████      
   ███                           █████          
     █████                 ██████               
♦️       ██████████████████                   ♣️
   ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      image = {
        enabled = true,
      },
    }

    local function git_root()
      local cwd = vim.uv.cwd() or vim.fn.getcwd()
      local git = vim.fs.find(".git", { path = cwd, upward = true })[1]
      return git and vim.fs.dirname(git) or cwd
    end

    vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer" })
    vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files { cwd = git_root() } end, { desc = "Find files (Root Dir)" })
    vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep { cwd = git_root() } end, { desc = "Grep (Root Dir)" })
    vim.keymap.set("n", "<leader>gg", function()
      if vim.fn.executable "lazygit" == 1 then
        Snacks.lazygit { cwd = git_root() }
      else
        vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
      end
    end, { desc = "Lazygit (Root Dir)" })
    vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
    vim.keymap.set("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help" })
    vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
  end,
}
