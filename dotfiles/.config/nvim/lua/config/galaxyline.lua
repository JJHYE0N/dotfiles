local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {
  'NvimTree',
  '__vista__',
  'DAP Scopes',
  'DAP BreakPoints',
  'DAP Stacks',
  'DAP Watches',
  'dbui',
  'packer'
}

gls.left[1] = {
  RainbowRed = {
    provider = function()
      return '▊ '
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        ['r?'] = ':CONFIRM',
        rm = '--MORE',
        R = 'REPLACE',
        Rv = 'VIRTUAL',
        s = 'SELECT',
        S = 'SELECT',
        ['r'] = 'HIT-ENTER',
        [''] = 'SELECT',
        t = 'TERMINAL',
        ['!'] = 'SHELL'
      }
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red
      }
      vim.api
          .nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
      return alias[vim.fn.mode()] .. '   '
    end,
    highlight = {colors.red, colors.bg, 'bold'}
  }
}

gls.left[3] = {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg}
  }
}

gls.left[4] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.bg
    }
  }
}
gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta, colors.bg, 'bold'}
  }
}

gls.left[6] = {
  GitIcon = {
    provider = function()
      return '  '
    end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.violet, colors.bg, 'bold'}
  }
}

gls.left[7] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.violet, colors.bg, 'bold'}
  }
}

gls.left[8] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green, colors.bg}
  }
}

gls.left[9] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange, colors.bg}
  }
}

gls.left[10] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
}

gls.left[13] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  }
}

gls.left[14] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg}
  }
}

gls.left[15] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan, colors.bg}
  }
}

gls.left[16] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg}
  }
}

gls.right[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function()
      local tbl = {['dashboard'] = true, [''] = true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan, colors.bg, 'bold'}
  }
}

gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg}
  }
}

gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg, 'bold'}
  }
}

gls.right[4] = {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg, 'bold'}
  }
}
gls.right[5] = {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.green, colors.bg, 'bold'}
  }
}

gls.right[6] = {
  RainbowBlue = {
    provider = function()
      return '  ▊'
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.blue, colors.bg, 'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg, 'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {provider = 'BufferIcon', highlight = {colors.fg, colors.bg}}
}
