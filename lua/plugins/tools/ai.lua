return {
  {
    "robitx/gp.nvim",
    cmd = {
      "GpChatNew",
      "GpChatPaste",
      "GpChatToggle",
      "GpRewrite",
      "GpPrepend",
      "GpContext",
      "GpNextAgent",
      "GpAgent",
      "GpStop",
    },
    keys = {
      -- Chat
      { "<C-g>c", "<Cmd>GpChatNew vsplit<CR>", mode = { "n", "i" }, desc = "New Chat" },
      { "<C-g>c", ":<C-u>'<,'>GpChatNew vsplit<CR>", mode = { "v" }, desc = "New Chat" },
      { "<C-g>t", "<Cmd>GpChatToggle split<CR>", mode = { "n", "i" }, desc = "Toggle Chat" },
      { "<C-g>t", ":<C-u>'<,'>GpChatToggle split<CR>", mode = { "v" }, desc = "Toggle Chat" },
      { "<C-g>f", "<Cmd>GpChatFinder<CR>", mode = { "n", "i" }, desc = "Find Chat" },
      { "<C-g>p", ":<C-u>'<,'>GpChatPaste<CR>", mode = { "v" }, desc = "Chat Paste" },
    },
    opts = {
      openai_api_key = {
        "security",
        "find-generic-password",
        "-w",
        "-s",
        "openai",
        "-a",
        "openai",
      },
      chat_conceal_model_params = false,
      whisper_language = "",
      toggle_target = "vsplit",
      style_chat_finder_border = "rounded",
      style_popup_border = "rounded",
      hooks = {
        --@param gp
        --@param params table
        Translator = function(gp, params)
          local agent = gp.get_command_agent()
          local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
          gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
        end,
      },
    },

    config = function(_, opts)
      require("gp").setup(opts)
    end,
  },
}
