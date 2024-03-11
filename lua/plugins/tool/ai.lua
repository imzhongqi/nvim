return {
  {
    "robitx/gp.nvim",
    event = {
      "BufRead */gp/chats/**.md",
    },
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
      "GpTranslator",
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
      openai_api_key = os.getenv "OPENAI_API_KEY" or {
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
      chat_confirm_delete = false,
      style_chat_finder_border = "rounded",
      style_popup_border = "rounded",
      hooks = {
        Translator = function(gp, params)
          local system_prompt = [[You are a professional,authentic translation engine,only returns translations.
Please use professional terminology of the corresponding language (programming language) for translation.
For example:
```go
// nil <Keep This Symbol>
// value <Keep This Symbol>
```
The translation is:
```go
nil <Keep This Symbol>
值<Keep This Symbol>
```]]
          local template = "Translate the content to {target_lang} Language,If it is a comment, Delete the comments before translating:"
            .. "```{{filetype}}\n{{selection}}\n```"
          gp.Prompt(params, gp.Target.popup, nil, "gpt-3.5-turbo-1106", template, system_prompt)
        end,
      },

      agents = {
        {
          name = "ChatGPT4",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are a general AI assistant.\n"
            .. "Please do not reply with some context that everyone knows, it will be redundant\n",
        },
        {
          name = "ChatGPT3-5",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-3.5-turbo-0125", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are a general AI assistant.\n\n"
            .. "The user provided the additional info about how they would like you to respond:\n\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Ask question if you need clarification to provide better answer.\n"
            .. "- Think deeply and carefully from first principles step by step.\n"
            .. "- Zoom out first to see the big picture and then zoom in to details.\n"
            .. "- Use Socratic method to improve your thinking and coding skills.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- Take a deep breath; You've got this!\n",
        },
        {
          name = "CodeGPT4",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
        {
          name = "CodeGPT3-5",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-3.5-turbo-instruct", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
      },
    },

    config = function(_, opts)
      require("gp").setup(opts)
    end,
  },
}
