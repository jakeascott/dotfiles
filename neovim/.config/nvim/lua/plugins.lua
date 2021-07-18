-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'modus_vivendi',
                    component_separators = {'', ''},
                    section_separators = {'', ''},
                    disabled_filetypes = {}
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }
        end,
    }

    use "tpope/vim-commentary"

    use 'tpope/vim-surround'

    use {
        'tpope/vim-fugitive',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<CR>', {noremap = true})
        end,
    }

    -- Requries ripgrep, bat
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', {noremap = true})
        end,
    }

    use {
        'kassio/neoterm',
        config = function()
            vim.api.nvim_set_var('neoterm_default_mod', 'vertical')
            vim.api.nvim_set_var('neoterm_size', 60)
            vim.api.nvim_set_var('neoterm_autoinsert', 1)
            vim.api.nvim_set_keymap('n', '<c-q>', ':Ttoggle<CR>', {noremap = true})
            vim.api.nvim_set_keymap('i', '<c-q>', '<Esc>:Ttoggle<CR>', {noremap = true})
            vim.api.nvim_set_keymap('t', '<c-q>', '<c-\\><c-n>:Ttoggle<CR>', {noremap = true})
        end,
    }

    use {
        'sbdchd/neoformat',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>F', ':Neoformat black<CR>', {noremap = true})
        end,
    }


    use {
        'szw/vim-maximizer',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>m', ':MaximizerToggle!<CR>', {noremap = true})
        end,
    }

    use {
        'ishan9299/modus-theme-vim',
        config = function()
            vim.api.nvim_exec('colorscheme modus-vivendi', false)
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    use 'ap/vim-css-color'

    use {
        "vhyrro/neorg",
        ft = "norg",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require('neorg').setup {
                -- Tell Neorg what modules to load
                load = {
                    ["core.defaults"] = {}, -- Load all the default modules
                    ["core.norg.concealer"] = {}, -- Allows for use of icons
                    ["core.norg.dirman"] = { -- Manage your directories with Neorg
                    config = {
                        workspaces = {
                            my_workspace = "~/Nextcloud/neorg"
                        }
                    }
                }
            },
        }
        end,
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig').pylsp.setup{}
        end,
    }

    use {
        'hrsh7th/nvim-compe',
        config = function()
            require('compe').setup {
                enabled = true;
                autocomplete = true;
                debug = false;
                min_length = 1;
                preselect = 'enable';
                throttle_time = 80;
                source_timeout = 200;
                incomplete_delay = 400;
                max_abbr_width = 100;
                max_kind_width = 100;
                max_menu_width = 100;
                documentation = true;

                source = {
                    path = true;
                    nvim_lsp = true;
                };
            }

            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local check_back_space = function()
                local col = vim.fn.col('.') - 1
                if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    return true
                else
                    return false
                end
            end

            -- Use (s-)tab to:
            --- move to prev/next item in completion menuone
            --- jump to prev/next snippet's placeholder
            _G.tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-n>"
                elseif check_back_space() then
                    return t "<Tab>"
                else
                    return vim.fn['compe#complete']()
                end
            end
            _G.s_tab_complete = function()
                if vim.fn.pumvisible() == 1 then
                    return t "<C-p>"
                else
                    return t "<S-Tab>"
                end
            end

            vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
        end,
    }
end)

