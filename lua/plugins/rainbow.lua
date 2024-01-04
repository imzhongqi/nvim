return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufFilePre", "BufRead" },
  config = function(_, opts)
    require("rainbow-delimiters.setup").setup(opts)
  end,
  opts = {},
}
