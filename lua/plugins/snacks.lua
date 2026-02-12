return {
  "snacks.nvim",
  event = "VimEnter",
  after = function()
    require("snacks").setup {
      animate = { enabled = true },
      notifier = { enabled = true },
      input = { enabled = true },
      quickfile = { enabled = true },
      bigfile = { enabled = true },
      picker = { enabled = true },
      explorer = { enabled = true },
      terminal = { enabled = true },
      words = { enabled = true },
      scroll = { enabled = true },
      dim = { enabled = true },
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

    vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

    local function git_root()
      local cwd = vim.uv.cwd() or vim.fn.getcwd()
      local git = vim.fs.find(".git", { path = cwd, upward = true })[1]
      return git and vim.fs.dirname(git) or cwd
    end

    local function project_root()
      local cwd = vim.uv.cwd() or vim.fn.getcwd()
      local root_markers = { ".git", "flake.nix", "package.json", "pyproject.toml", "Cargo.toml", "go.mod" }
      for _, marker in ipairs(root_markers) do
        local hit = vim.fs.find(marker, { path = cwd, upward = true })[1]
        if hit then
          return vim.fs.dirname(hit)
        end
      end
      return cwd
    end

    vim.keymap.set("n", "<leader><space>", function() Snacks.picker.files { cwd = project_root() } end, { desc = "Find files (Root Dir)" })
    vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle scratch buffer" })
    vim.keymap.set("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select scratch buffer" })
    vim.keymap.set("n", "<leader>dps", function() Snacks.profiler.scratch() end, { desc = "Profiler scratch buffer" })
    vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep { cwd = project_root() } end, { desc = "Grep (Root Dir)" })
    vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command history" })

    vim.keymap.set("n", "<leader>e", function() Snacks.explorer { cwd = project_root() } end, { desc = "Explorer Snacks (root dir)" })
    vim.keymap.set("n", "<leader>E", function() Snacks.explorer() end, { desc = "Explorer Snacks (cwd)" })
    vim.keymap.set("n", "<leader>fe", function() Snacks.explorer { cwd = project_root() } end, { desc = "Explorer Snacks (root dir)" })
    vim.keymap.set("n", "<leader>fE", function() Snacks.explorer() end, { desc = "Explorer Snacks (cwd)" })

    vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fB", function() Snacks.picker.buffers { hidden = true, nofile = true } end, { desc = "Buffers (all)" })
    vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end, { desc = "Find config file" })
    vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files { cwd = project_root() } end, { desc = "Find files (Root Dir)" })
    vim.keymap.set("n", "<leader>fF", function() Snacks.picker.files { cwd = vim.uv.cwd() } end, { desc = "Find files (cwd)" })
    vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find files (git-files)" })
    vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
    vim.keymap.set("n", "<leader>fR", function() Snacks.picker.recent { filter = { cwd = true } } end, { desc = "Recent (cwd)" })
    vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })

    vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git diff (hunks)" })
    vim.keymap.set("n", "<leader>gD", function() Snacks.picker.git_diff { base = "origin", group = true } end, { desc = "Git diff (origin)" })
    vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git status" })
    vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git stash" })
    vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub issues (open)" })
    vim.keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue { state = "all" } end, { desc = "GitHub issues (all)" })
    vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub pull requests (open)" })
    vim.keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr { state = "all" } end, { desc = "GitHub pull requests (all)" })

    vim.keymap.set("n", "<leader>gg", function()
      if vim.fn.executable "lazygit" == 1 then
        Snacks.lazygit { cwd = git_root() }
      else
        vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
      end
    end, { desc = "Lazygit (Root Dir)" })
    vim.keymap.set("n", "<leader>gG", function()
      if vim.fn.executable "lazygit" == 1 then
        Snacks.lazygit()
      else
        vim.notify("lazygit not found in PATH", vim.log.levels.WARN)
      end
    end, { desc = "Lazygit (cwd)" })

    vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification history" })
    vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss all notifications" })

    vim.keymap.set("n", [[<leader>s"]], function() Snacks.picker.registers() end, { desc = "Registers" })
    vim.keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search history" })
    vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
    vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer lines" })
    vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep open buffers" })
    vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command history" })
    vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
    vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer diagnostics" })
    vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep { cwd = project_root() } end, { desc = "Grep (Root Dir)" })
    vim.keymap.set("n", "<leader>sG", function() Snacks.picker.grep { cwd = vim.uv.cwd() } end, { desc = "Grep (cwd)" })
    vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help pages" })
    vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
    vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
    vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
    vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location list" })
    vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
    vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man pages" })
    vim.keymap.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search plugin spec" })
    vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix list" })
    vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
    vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })
    vim.keymap.set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word { cwd = project_root() } end, { desc = "Visual selection or word (Root Dir)" })
    vim.keymap.set({ "n", "x" }, "<leader>sW", function() Snacks.picker.grep_word { cwd = vim.uv.cwd() } end, { desc = "Visual selection or word (cwd)" })

    Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
    Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
    Snacks.toggle.diagnostics():map "<leader>ud"
    Snacks.toggle.line_number():map "<leader>ul"
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map "<leader>uc"
    Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map "<leader>uA"
    Snacks.toggle.treesitter():map "<leader>uT"
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
    Snacks.toggle.dim():map "<leader>uD"
    Snacks.toggle.animate():map "<leader>ua"
    Snacks.toggle.indent():map "<leader>ug"
    Snacks.toggle.scroll():map "<leader>uS"
    Snacks.toggle.profiler():map "<leader>dpp"
    Snacks.toggle.profiler_highlights():map "<leader>dph"
    if vim.lsp.inlay_hint then
      Snacks.toggle.inlay_hints():map "<leader>uh"
    end

    vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git log (cwd)" })
    vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git blame line" })
    vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git current file history" })
    vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log { cwd = git_root() } end, { desc = "Git log" })
    vim.keymap.set({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git browse (open)" })
    vim.keymap.set({ "n", "x" }, "<leader>gY", function()
      Snacks.gitbrowse { open = function(url) vim.fn.setreg("+", url) end, notify = false }
    end, { desc = "Git browse (copy)" })

    vim.keymap.set("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
    vim.keymap.set("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = project_root() }) end, { desc = "Terminal (Root Dir)" })
    vim.keymap.set({ "n", "t" }, "<C-/>", function() Snacks.terminal(nil, { cwd = project_root() }) end, { desc = "Terminal (Root Dir)" })
    vim.keymap.set({ "n", "t" }, "<C-_>", function() Snacks.terminal(nil, { cwd = project_root() }) end, { desc = "which_key_ignore" })

    Snacks.toggle.zoom():map("<leader>wm"):map "<leader>uZ"
    Snacks.toggle.zen():map "<leader>uz"

    vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
    vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect pos" })
    vim.keymap.set("n", "<leader>uI", function()
      vim.treesitter.inspect_tree()
      vim.api.nvim_input "I"
    end, { desc = "Inspect tree" })
  end,
}
