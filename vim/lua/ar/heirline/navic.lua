return {
  condition = function(self)
    if not require('nvim-navic').is_available() then
      return false
    end

    self.data = require('nvim-navic').get_data() or {}
    return not vim.tbl_isempty(self.data)
  end,
  static = {
    -- create a type highlight map
    type_hl = {
      File          = 'Directory',
      Module        = '@include',
      Namespace     = '@namespace',
      Package       = '@include',
      Class         = '@structure',
      Method        = '@method',
      Property      = '@property',
      Field         = '@field',
      Constructor   = '@constructor',
      Enum          = '@field',
      Interface     = '@type',
      Function      = '@function',
      Variable      = '@variable',
      Constant      = '@constant',
      String        = '@string',
      Number        = '@number',
      Boolean       = '@boolean',
      Array         = '@field',
      Object        = '@type',
      Key           = '@keyword',
      Null          = '@comment',
      EnumMember    = '@field',
      Struct        = '@structure',
      Event         = '@keyword',
      Operator      = '@operator',
      TypeParameter = '@type',
    },
  },
  flexible = 3,
  {
    init = function(self)
      local children = {}
      for i, d in ipairs(self.data) do
        local child = {
          {
            provider = d.icon,
            hl = self.type_hl[d.type],
          },
          {
            provider = d.name,
            hl = { fg = 'fg2' },
          },
        }

        -- add a separator only if needed
        if #self.data > 1 and i < #self.data then
          table.insert(child, {
            provider = '  ',
            hl = { fg = 'fg5' },
          })
        end

        table.insert(children, child)
      end
      -- instantiate the new child, overwriting the previous one
      self.child = self:new(children, 1)
    end,
    -- evaluate the children containing navic components
    provider = function(self)
      return self.child:eval()
    end,
    hl = { fg = 'gray' },
    update = 'CursorMoved'
  },
  { provider = '' }
}
