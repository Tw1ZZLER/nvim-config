return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim", -- For async operations
  },
  lazy = false, -- Ensure lualine loads immediately
  priority = 900, -- High priority to load early
  config = function()
    local lualine = require "lualine"
    local uv = vim.uv or vim.loop

    -- PlatformIO Command Wrapper
    local function pio_command(command)
      return function()
        local cmd = string.format("pio %s", command)
        vim.fn.jobstart(cmd, {
          on_stdout = function(_, data)
            if data then vim.notify(table.concat(data), vim.log.levels.INFO) end
          end,
          on_stderr = function(_, data)
            if data then vim.notify(table.concat(data), vim.log.levels.ERROR) end
          end,
        })
      end
    end

    -- Environment Switcher
    local environments = {
      { name = "Default", project = "ESP32PRCodebase" },
      { name = "Debug", project = "ESP32PRCodebase" },
      { name = "Release", project = "ESP32PRCodebase" },
    }
    local current_env_index = 1

    local function switch_environment()
      -- Create a selection menu
      local menu_items = {}
      for i, env in ipairs(environments) do
        table.insert(menu_items, string.format("%d. %s (%s)", i, env.name, env.project))
      end

      vim.ui.select(menu_items, {
        prompt = "Select PlatformIO Environment",
        telescope = require("telescope.themes").get_dropdown {},
      }, function(choice)
        if choice then
          local index = tonumber(choice:sub(1, 1))
          current_env_index = index
          vim.notify(string.format("Switched to %s", environments[index].name))
        end
      end)
    end

    -- da epic port switcher
    local usb_ports = {}
    local current_port_index = 1

    local function refresh_usb_ports()
      -- This would ideally use a system-specific method to list USB ports
      usb_ports = {
        "/dev/ttyUSB0",
        "/dev/ttyUSB1",
        "/dev/ttyACM0",
        "/dev/ttyACM1",
      }
    end

    local function switch_usb_port()
      refresh_usb_ports()

      local menu_items = {}
      for i, port in ipairs(usb_ports) do
        table.insert(menu_items, string.format("%d. %s", i, port))
      end

      vim.ui.select(menu_items, {
        prompt = "Select USB Port",
        telescope = require("telescope.themes").get_dropdown {},
      }, function(choice)
        if choice then
          local index = tonumber(choice:sub(1, 1))
          current_port_index = index
          vim.notify(string.format("Switched to port %s", usb_ports[index]))
        end
      end)
    end

    -- platformio project condition
    local function is_platformio_project() return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1 end

    -- default configuration
    local default_config = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        "nvim-tree",
        "quickfix",
      },
    }

    -- platformio-specific configuration
    local platformio_config = {
      options = default_config.options,
      sections = {
        lualine_a = default_config.sections.lualine_a,
        lualine_b = default_config.sections.lualine_b,
        lualine_c = {
          -- PIO action buttons
          {
            function() return "🏠" end, -- Home
            on_click = pio_command "home",
          },
          {
            function() return "✅" end, -- Build
            on_click = pio_command "run",
          },
          {
            function() return "➡️" end, -- Upload
            on_click = pio_command "upload",
          },
          {
            function() return "🗑️" end, -- Clean
            on_click = pio_command "clean",
          },
          {
            function() return "🧪" end, -- Test
            on_click = pio_command "test",
          },
          {
            function() return "🔌" end, -- Serial Monitor
            on_click = pio_command "device monitor",
          },
          {
            function() return "💻" end, -- New Terminal
            on_click = function()
              vim.cmd "terminal"
              vim.cmd "set nonu" -- Optional: disable line numbers in terminal
            end,
          },
          -- PIO environment Switcher
          {
            function()
              local current_env = environments[current_env_index]
              return string.format("📁 %s (%s)", current_env.name, current_env.project)
            end,
            on_click = switch_environment,
          },
          -- PIO port switcher
          {
            function() return string.format("🔌 %s", usb_ports[current_port_index]) end,
            on_click = switch_usb_port,
          },
        },
        lualine_x = default_config.sections.lualine_x,
        lualine_y = default_config.sections.lualine_y,
        lualine_z = default_config.sections.lualine_z,
      },
      inactive_sections = default_config.inactive_sections,
      extensions = default_config.extensions,
    }
    refresh_usb_ports()

    -- Choose configuration based on project type
    local final_config = is_platformio_project() and platformio_config or default_config

    -- Setup Lualine
    lualine.setup(final_config)
  end,
}
