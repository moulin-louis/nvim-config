-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    close_if_last_window = true,
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = '\u{e702}', -- nf-dev-git_branch
          modified = '\u{f040}', -- nf-fa-pencil
          deleted = '\u{f00d}', -- nf-fa-close
          renamed = '\u{f061}', -- nf-fa-arrow_right
          -- Status type
          untracked = '\u{f059}', -- nf-fa-question_circle
          ignored = '\u{f070}', -- nf-fa-eye_slash
          unstaged = '\u{f111}', -- nf-fa-circle
          staged = '\u{f00c}', -- nf-fa-check
          conflict = '\u{f071}', -- nf-fa-exclamation_triangle
        },
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = false,
            },
          },
        },
      },
    },
  },
}
