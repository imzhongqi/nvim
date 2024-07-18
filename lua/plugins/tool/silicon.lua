return {
  "michaelrommel/nvim-silicon",
  cmd = { "Silicon", "SiliconSave" },
  opts = {
    theme = "gruvbox-dark",
    background = "#ffcf73",
    font = "CaskaydiaCove Nerd Font; PingFang SC",
    line_offset = function(args)
      if args.range == 0 then
        return 1
      end
      return args.line1
    end,
    line_pad = 10,
    gobble = false,
    num_separator = " ",
    language = function() return vim.bo.filetype end,
    output = function()
      return (
        _Util.path_join(vim.fn.expand "%:p:h:t", vim.fn.expand "%:t"):gsub("%/", "%%")
        .. "-"
        .. os.date "!%Y%m%d%H%M%S"
        .. ".png"
      )
    end,
  },
  config = function(_, opts)
    local silicon = require "silicon"

    local options = silicon.parse_options(opts)
    vim.api.nvim_create_user_command("Silicon", function(args)
      options.to_clipboard = true
      if args.line2 - args.line1 > 300 then
        vim.notify "disable copy to clipboard, because the lines are too many."
        options.to_clipboard = false
      end
      options.output = not options.to_clipboard
      silicon.start(args, options)
    end, {
      desc = "convert range to code image representation",
      force = false,
      range = true,
    })

    local save_options = vim.deepcopy(options, false)
    vim.api.nvim_create_user_command("SiliconSave", function(args)
      save_options.to_clipboard = false
      if args.args and args.args ~= "" then
        save_options.output = args.args
      end
      silicon.start(args, save_options)
    end, {
      desc = "convert range to code image representation and save to path",
      force = false,
      range = true,
      nargs = "*",
    })
  end,
}
