return {
    -- FILES
    {
        { -- Fuzzy Finder (files, lsp, etc)
            "nvim-telescope/telescope.nvim",
            lazy = true,
            cmd = { "Telescope", "Easypick" },
            branch = "0.1.x",
            dependencies = {
                "nvim-telescope/telescope-frecency.nvim",
                { "jvgrootveld/telescope-zoxide" },
                { "tiagovla/scope.nvim" },
                "nvim-lua/plenary.nvim",
                "axkirillov/easypick.nvim",
                { -- If encountering errors, see telescope-fzf-native README for installation instructions
                    "nvim-telescope/telescope-fzf-native.nvim",

                    -- `build` is used to run some command when the plugin is installed/updated.
                    -- This is only run then, not every time Neovim starts up.
                    build = "make",

                    -- `cond` is a condition used to determine whether this plugin should be
                    -- installed and loaded.
                    cond = function()
                        return vim.fn.executable("make") == 1
                    end,
                },
                { "nvim-telescope/telescope-ui-select.nvim" },

                -- Useful for getting pretty icons, but requires a Nerd Font.
                { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
            },
            config = function()
                -- [[ Configure Telescope ]]
                -- See `:help telescope` and `:help telescope.setup()`
                require("telescope").setup({
                    -- You can put your default mappings / updates / etc. in here
                    --  All the info you're looking for is in `:help telescope.setup()`
                    --
                    defaults = {
                        mappings = {
                            i = { ["<c-enter>"] = "to_fuzzy_refine" },
                        },
                    },
                    pickers = {},
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown(),
                        },
                        frecency = {
                            show_scores = false,
                            show_unindexed = true,
                            db_safe_mode = false,
                            ignore_patterns = { "*.git/*", "*/tmp/*" },
                            disable_devicons = false,
                        },
                        fzf = {
                            fuzzy = true, -- false will only do exact matching
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true, -- override the file sorter
                            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                            -- the default case_mode is "smart_case"
                        },
                        zoxide = {
                            prompt_title = "[ ZOXIDE ]",
                            list_command = "zoxide query -ls",
                            mappings = {
                                default = {
                                    action = function(selection)
                                        vim.cmd("cd " .. selection.path)
                                    end,
                                    after_action = function(selection)
                                        print("Directory changed to " .. selection.path)
                                    end,
                                },
                            },
                        },
                        lazy = {
                            -- Optional theme (the extension doesn't set a default theme)
                            theme = "ivy",
                            -- Whether or not to show the icon in the first column
                            show_icon = true,
                            -- Mappings for the actions
                            mappings = {
                                open_in_browser = "<C-o>",
                                open_in_find_files = "<C-f>",
                                open_in_live_grep = "<C-g>",
                                open_plugins_picker = "<C-b>", -- Works only after having called first another action
                                open_lazy_root_find_files = "<C-r>f",
                                open_lazy_root_live_grep = "<C-r>g",
                            },
                            -- Other telescope configuration options
                        },
                    },
                })

                -- Enable Telescope extensions if they are installed
                pcall(require("telescope").load_extension, "fzf")
                pcall(require("telescope").load_extension, "ui-select")
                pcall(require("telescope").load_extension, "frecency")
                pcall(require("telescope").load_extension, "zoxide")
                pcall(require("telescope").load_extension, "scope")

                vim.keymap.set(
                    "n",
                    "<leader>fe",
                    "<cmd>Telescope frecency<cr>",
                    { desc = "Frecency" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>zo",
                    "<cmd>Telescope zoxide list<cr>",
                    { desc = "Zoxide" }
                )

                -- See `:help telescope.builtin`
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
                vim.keymap.set(
                    "n",
                    "<leader>fs",
                    builtin.builtin,
                    { desc = "[S]earch [S]elect Telescope" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>fw",
                    builtin.grep_string,
                    { desc = "[S]earch current [W]ord" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>fg",
                    builtin.live_grep,
                    { desc = "[S]earch by [G]rep" }
                )
                vim.keymap.set(
                    "n",
                    "<leader>fd",
                    builtin.diagnostics,
                    { desc = "[S]earch [D]iagnostics" }
                )
                vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
                vim.keymap.set(
                    "n",
                    "<leader>f.",
                    builtin.oldfiles,
                    { desc = '[S]earch Recent Files ("." for repeat)' }
                )
                vim.keymap.set(
                    "n",
                    "<leader><leader>",
                    builtin.buffers,
                    { desc = "[ ] Find existing buffers" }
                )

                -- Slightly advanced example of overriding default behavior and theme
                vim.keymap.set("n", "<leader>/", function()
                    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end, { desc = "[/] Fuzzily search in current buffer" })

                -- It's also possible to pass additional configuration options.
                --  See `:help telescope.builtin.live_grep()` for information about particular keys
                vim.keymap.set("n", "<leader>s/", function()
                    builtin.live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end, { desc = "[S]earch [/] in Open Files" })

                -- Shortcut for searching your Neovim configuration files
                vim.keymap.set("n", "<leader>fn", function()
                    builtin.find_files({ cwd = vim.fn.stdpath("config") })
                end, { desc = "[S]earch [N]eovim files" })
            end,
        },
    },

    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require("plugins.configs.nvimtree")
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = true,
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer Explorer",
            },
        },
        opts = {
            filesystem = {
                window = {
                    mappings = {
                        ["\\"] = "close_window",
                    },
                },
            },
        },
    },
    {
        "smiteshp/nvim-navic",
        config = function()
            require("nvim-navic").setup({
                lsp = {
                    auto_attach = true,
                    -- priority order for attaching LSP servers
                    -- to the current buffer
                    preference = {
                        "html",
                        "templ",
                    },
                },
                separator = " 󰁔 ",
            })
        end,
    },

    -- search/replace in multiple files
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>cr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    },

    -- which-key helps you remember key bindings by showing a popup
    -- with the active keybindings of the command you started typing.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            defaults = {},
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader><tab>", group = "tabs" },
                    { "<leader>c", group = "code" },
                    { "<leader>f", group = "file/find" },
                    { "<leader>g", group = "git" },
                    { "<leader>gh", group = "hunks" },
                    { "<leader>q", group = "quit/session" },
                    { "<leader>s", group = "search" },
                    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    {
                        "<leader>x",
                        group = "diagnostics/quickfix",
                        icon = { icon = "󱖫 ", color = "green" },
                    },
                    { "[", group = "prev" },
                    { "]", group = "next" },
                    { "g", group = "goto" },
                    { "gs", group = "surround" },
                    { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    -- better descriptions
                    { "gx", desc = "Open with system app" },
                },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Keymaps (which-key)",
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            if not vim.tbl_isempty(opts.defaults) then
                vim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
                wk.register(opts.defaults)
            end
        end,
    },

    -- git signs highlights text that has changed since the list
    -- git commit, and also lets you interactively stage & unstage
    -- hunks in a commit.
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

        -- stylua: ignore start
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },

    -- Finds and lists all of the TODO, HACK, BUG, etc comment
    -- in your project and loads them into a browsable list.
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "VeryLazy",
        opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    },
    {
        --Undo Tree
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = function()
            local keymap = vim.keymap
            keymap.set(
                "n",
                "<leader>u",
                ":OutlineClose<CR>:DBUIClose<CR>:UndotreeToggle<CR>",
                { desc = "UndotreeToggle" }
            )
            vim.g.undotree_SetFocusWhenToggle = true
        end,
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
}
