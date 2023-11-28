local utils = require "user.utils"
--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below
-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

        -- Configure AstroNvim updates
        updater = {
                remote = "origin", -- remote to use
                channel = "nightly", -- "stable" or "nightly"
                version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main", -- branch name (NIGHTLY ONLY)
                commit = nil, -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false, -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = false, -- automatically reload and sync packer after a successful update
                auto_quit = false, -- automatically quit the current session after a successful update
                -- remotes = { -- easily add new remotes to track
                --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
                --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
                --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
                -- },
        },

        -- Set colorscheme to use
        colorscheme = "default_theme",

        -- Add highlight groups in any theme
        highlights = {
                -- init = { -- this table overrides highlights in all themes
                --   Normal = { bg = "#000000" },
                -- }
                -- duskfox = { -- a table of overrides/changes to the duskfox theme
                --   Normal = { bg = "#000000" },
                -- },
        },

        -- set vim options here (vim.<first_key>.<second_key> = value)
        options = {
                opt = {
                        -- set to true or false etc.
                        relativenumber = true, -- sets vim.opt.relativenumber
                        number = true, -- sets vim.opt.number
                        spell = false, -- sets vim.opt.spell
                        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
                        wrap = false, -- sets vim.opt.wrap
                },
                g = {
                        mapleader = " ", -- sets vim.g.mapleader
                        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
                        cmp_enabled = true, -- enable completion at start
                        autopairs_enabled = true, -- enable autopairs at start
                        diagnostics_enabled = true, -- enable diagnostics at start
                        status_diagnostics_enabled = true, -- enable diagnostics in statusline
                        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
                        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
                        heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
                },
        },
        -- If you need more control, you can use the function()...end notation
        -- options = function(local_vim)
        --   local_vim.opt.relativenumber = true
        --   local_vim.g.mapleader = " "
        --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
        --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
        --
        --   return local_vim
        -- end,

        -- Set dashboard header
        header = {
                " █████  ███████ ████████ ██████   ██████",
                "██   ██ ██         ██    ██   ██ ██    ██",
                "███████ ███████    ██    ██████  ██    ██",
                "██   ██      ██    ██    ██   ██ ██    ██",
                "██   ██ ███████    ██    ██   ██  ██████",
                " ",
                "    ███    ██ ██    ██ ██ ███    ███",
                "    ████   ██ ██    ██ ██ ████  ████",
                "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "    ██   ████   ████   ██ ██      ██",
        },

        -- Default theme configuration
        default_theme = {
                -- Modify the color palette for the default theme
                colors = { fg = "#abb2bf", bg = "#1e222a" },
                highlights = function(hl) -- or a function that returns a new table of colors to set
                        local C = require "default_theme.colors"

                        hl.Normal = { fg = C.fg, bg = C.bg }

                        -- New approach instead of diagnostic_style
                        hl.DiagnosticError.italic = true
                        hl.DiagnosticHint.italic = true
                        hl.DiagnosticInfo.italic = true
                        hl.DiagnosticWarn.italic = true

                        return hl
                end,
                -- enable or disable highlighting for extra plugins
                plugins = {
                        aerial = true,
                        beacon = false,
                        bufferline = true,
                        cmp = true,
                        dashboard = true,
                        highlighturl = true,
                        hop = false,
                        indent_blankline = true,
                        lightspeed = false,
                        ["neo-tree"] = true,
                        notify = true,
                        ["nvim-tree"] = false,
                        ["nvim-web-devicons"] = true,
                        rainbow = true,
                        symbols_outline = false,
                        telescope = true,
                        treesitter = true,
                        vimwiki = false,
                        ["which-key"] = true,
                },
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = { virtual_text = true, underline = true },

        -- Extend LSP configuration
        lsp = {
                -- enable servers that you already have installed without mason
                skip_setup = { "rust_analyzer" },
                servers = {
                        -- "pyright"
                },
                formatting = {
                        -- control auto formatting on save
                        format_on_save = {
                                enabled = true, -- enable or disable format on save globally
                                allow_filetypes = { -- enable format on save for specified filetypes only
                                        -- "go",
                                },
                                ignore_filetypes = { -- disable format on save for specified filetypes
                                        -- "python",
                                },
                        },
                        disabled = { -- disable formatting capabilities for the listed language servers
                                -- "sumneko_lua",
                        },
                        timeout_ms = 1000, -- default format timeout
                        -- filter = function(client) -- fully override the default formatting function
                        --   return true
                        -- end
                },
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                -- ["<leader>lf"] = false -- disable formatting keymap
                                ["<leader>la"] = false,
                        },
                },
                -- add to the global LSP on_attach function
                -- on_attach = function(client, bufnr)
                -- end,

                -- override the mason server-registration function
                -- server_registration = function(server, opts)
                --   require("lspconfig")[server].setup(opts)
                -- end,

                -- Add overrides for LSP server settings, the keys are the name of the server
                ["server-settings"] = {
                        -- example for addings schemas to yamlls
                        -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
                        --   settings = {
                        --     yaml = {
                        --       schemas = {
                        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        --       },
                        --     },
                        --   },
                        -- },
                        -- pyright = {
                        --     settings = {
                        --         python = {
                        --             pythonPath = ""
                        --         }
                        --     }
                        -- }
                        rust_analyzer = {
                                settings = {
                                        ["rust-analyzer"] = {
                                                cargo = { allFeatures = true },
                                                checkOnSave = {
                                                        command = "clippy",
                                                        extraArgs = "--no-deps",
                                                },
                                        },
                                },
                        },
                        pylsp = {
                                settings = {
                                        pylsp = {
                                                plugins = {
                                                        pycodestyle = { enabled = false },
                                                        pyflakes = { enabled = false },
                                                        pylint = { enabled = false },
                                                },
                                        },
                                },
                        },
                },
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                        ["<leader>bc"] = {
                                "<cmd>BufferLinePickClose<cr>",
                                desc = "Pick to close",
                        },
                        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                        ["<leader>bt"] = {
                                "<cmd>BufferLineSortByTabs<cr>",
                                desc = "Sort by tabs",
                        },
                        ["<leader>a"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
                        -- quick save
                        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
                        ["<leader>sv"] = { ":luafile $MYVIMRC<CR>", desc = "Source nvim config" },
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
                v = {
                        ["<leader>a"] = { function() vim.lsp.buf.code_action() end, desc = "LSP Code Action" },
                },
        },

        -- Configure plugins
        plugins = {
                init = function(default_plugins)
                        default_plugins["akinsho/bufferline.nvim"]["cond"] = utils.firenvim_not_active
                        -- default_plugins["rebelot/heirline.nvim"]["cond"] = utils.firenvim_not_active
                        default_plugins["nvim-neo-tree/neo-tree.nvim"]["cond"] = utils.firenvim_not_active
                        -- default_plugins["akinsho/bufferline.nvim"]["disable"] = not utils.firenvim_not_active()
                        -- default_plugins["rebelot/heirline.nvim"]["disable"] = not utils.firenvim_not_active()
                        -- default_plugins["nvim-neo-tree/neo-tree.nvim"]["disable"] = not utils.firenvim_not_active()

                        local my_plugins = {
                                {
                                        "glacambre/firenvim",
                                        run = function() vim.fn["firenvim#install"](0) end,
                                },
                                {
                                        "kdarkhan/rust-tools.nvim",
                                        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
                                        config = function()
                                                require("rust-tools").setup {
                                                        server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
                                                        inlay_hints = {
                                                                right_align = true,
                                                        },
                                                }
                                        end,
                                },
                                {
                                        "Saecki/crates.nvim",
                                        event = { "BufRead Cargo.toml" },
                                        requires = "plenary.nvim",
                                        config = function()
                                                require("crates").setup {
                                                        null_ls = {
                                                                enabled = true,
                                                                name = "Crates",
                                                        },
                                                }
                                                astronvim.add_user_cmp_source "crates"
                                        end,
                                },
                        }
                        return vim.tbl_deep_extend("force", default_plugins, my_plugins)
                end,
                -- init = {
                --         -- You can disable default plugins as follows:
                --         -- ["goolord/alpha-nvim"] = { disable = true },
                --
                --         -- You can also add new plugins here as well:
                --         -- Add plugins, the packer syntax without the "use"
                --         -- { "andweeb/presence.nvim" },
                --         -- {
                --         --   "ray-x/lsp_signature.nvim",
                --         --   event = "BufRead",
                --         --   config = function()
                --         --     require("lsp_signature").setup()
                --         --   end,
                --         -- },
                --
                --         -- We also support a key value style plugin definition similar to NvChad:
                --         -- ["ray-x/lsp_signature.nvim"] = {
                --         --   event = "BufRead",
                --         --   config = function()
                --         --     require("lsp_signature").setup()
                --         --   end,
                --         -- },
                --                         },
                -- All other entries override the require("<key>").setup({...}) call for default plugins
                ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
                        -- config variable is the default configuration table for the setup function call
                        local null_ls = require "null-ls"
                        local f = null_ls.builtins.formatting
                        local d = null_ls.builtins.diagnostics
                        -- Check supported formatters and linters
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
                        config.sources = {
                                -- Set a formatter
                                f.stylua,
                                -- null_ls.builtins.formatting.black,
                                -- null_ls.builtins.formatting.isort,
                                -- null_ls.builtins.formatting.rustfmt,
                                -- null_ls.builtins.diagnostics.luacheck,
                                d.pyproject_flake8.with { command = "flake8p" },
                                d.mypy.with {
                                        "--python-executable",
                                        utils.get_python_binary_path(vim.fn.getcwd()),
                                        "--ignore-missing-imports",
                                },
                                -- null_ls.builtins.formatting.prettier,
                        }
                        return config -- return final config table
                end,
                treesitter = { -- overrides `require("treesitter").setup(...)`
                        -- ensure_installed = { "lua" },
                },
                ["neo-tree"] = {
                        filesystem = {
                                filtered_items = {
                                        visible = true,
                                        hide_dotfiles = false,
                                        hide_gitignored = false,
                                },
                        },
                },
                -- use mason-lspconfig to configure LSP installations
                ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
                        ensure_installed = { "sumneko_lua", "rust_analyzer" },
                },
                -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
                ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
                        -- ensure_installed = { "prettier", "stylua" },
                        -- automatic_installation = { exclude = { "mypy" } }
                },
                ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
                        -- ensure_installed = { "python" },
                },
        },

        -- LuaSnip Options
        luasnip = {
                -- Extend filetypes
                filetype_extend = {
                        -- javascript = { "javascriptreact" },
                },
                -- Configure luasnip loaders (vscode, lua, and/or snipmate)
                vscode = {
                        -- Add paths for including more VS Code style snippets in luasnip
                        paths = {},
                },
        },

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        luasnip = 750,
                        crates = 600,
                        buffer = 500,
                        path = 250,
                },
        },

        -- Customize Heirline options
        heirline = {
                -- -- Customize different separators between sections
                -- separators = {
                --   tab = { "", "" },
                -- },
                -- -- Customize colors for each element each element has a `_fg` and a `_bg`
                -- colors = function(colors)
                --   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
                --   return colors
                -- end,
                -- -- Customize attributes of highlighting in Heirline components
                -- attributes = {
                --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
                --   git_branch = { bold = true }, -- bold the git branch statusline component
                -- },
                -- -- Customize if icons should be highlighted
                -- icon_highlights = {
                --   breadcrumbs = false, -- LSP symbols in the breadcrumbs
                --   file_icon = {
                --     winbar = false, -- Filetype icon in the winbar inactive windows
                --     statusline = true, -- Filetype icon in the statusline
                --   },
                -- },
        },

        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
                                        ["b"] = { name = "Buffer" },
                                },
                        },
                },
        },

        -- This function is run last and is a good place to configuring
        -- augroups/autocommands and custom filetypes also this just pure lua so
        -- anything that doesn't fit in the normal config locations above can go here
        polish = function()
                -- Set up custom filetypes
                -- vim.filetype.add {
                --   extension = {
                --     foo = "fooscript",
                --   },
                --   filename = {
                --     ["Foofile"] = "fooscript",
                --   },
                --   pattern = {
                --     ["~/%.config/foo/.*"] = "fooscript",
                --   },
                -- }
                require "user.autocommands"
                vim.g.firenvim_config = {
                        globalSettings = {
                                ignoreKeys = {
                                        all = { "<C-->" },
                                        normal = { "<C-1>", "<C-2>" },
                                },
                                alt = "all",
                        },
                        localSettings = {
                                [".*"] = {
                                        cmdline = "firenvim",
                                        -- content = "text",
                                        priority = 0,
                                        selector = "textarea",
                                        takeover = "never",
                                },
                        },
                }
        end,
}

return config
