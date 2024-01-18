return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- event = "VeryLazy",
  keys = function()
    local harpoon = require("harpoon")

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    return {
      {
        "<leader>hl",
        function()
          toggle_telescope(harpoon:list())
        end,
        desc = "Show the harpoon list",
      },
      {
        "<leader>ha",
        function()
          harpoon:list():append()
        end,
        desc = "Add to harpoon list",
      },
      {
        "<leader>hd",
        function()
          harpoon:list():remove()
        end,
        desc = "Delete harpoon list item",
      },
      {
        "<C-p>",
        function()
          harpoon:list():prepend():prev({ ui_nav_wrap = true })
        end,
        desc = "Go to previous harpoon item",
      },
      {
        "<C-n>",
        function()
          harpoon:list():prepend():next({ ui_nav_wrap = true })
        end,
        desc = "Go to next harpoon item",
      },
    }
  end,
  opts = {},
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)
  end,
}
