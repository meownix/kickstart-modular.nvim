return {
  'huggingface/llm.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('llm').setup({
      backend = 'ollama',
      model = 'qwen2.5-coder:0.5b',
      url = 'http://localhost:11434',
      fim = {
        enabled = true,
        prefix = '<|fim_prefix|>',
        middle = '<|fim_middle|>',
        suffix = '<|fim_suffix|>',
      },
      accept_keymap = '<C-y>',
      dismiss_keymap = '<C-e>',
      enable_suggestions_on_startup = false,
      enable_suggestions_on_files = '*',
      request_body = {
        options = {
          temperature = 0.2,
          num_predict = 128,
        },
      },
    })

    -- Manual trigger suggestion with <C-g> in Insert mode
    vim.keymap.set('i', '<C-g>', function()
      require('llm.completion').lsp_suggest()
    end, { silent = true, desc = 'Trigger LLM completion' })

    -- Toggle LLM autocomplete with <leader>At (Aider autocomplete toggle)
    vim.keymap.set('n', '<leader>At', function()
      require('llm.completion').toggle_suggestion()
      pcall(function()
        require('lualine').refresh { place = { 'statusline' }, force = true }
      end)
    end, { silent = true, desc = 'Toggle LLM autocomplete' })

    -- Choose and switch available model with <leader>Am
    vim.keymap.set('n', '<leader>Am', function()
      local models = {}
      local lines = vim.fn.systemlist("ollama list")
      for i = 2, #lines do
        local model = lines[i]:match("^(%S+)")
        if model then
          table.insert(models, model)
        end
      end

      if #models == 0 then
        vim.notify("[LLM] No models found in Ollama.", vim.log.levels.WARN)
        return
      end

      vim.ui.select(models, {
        prompt = "Select LLM Model:",
      }, function(choice)
        if choice then
          require('llm.config').get().model = choice
          vim.notify("[LLM] Switched model to: " .. choice, vim.log.levels.INFO)
          pcall(function()
            require('lualine').refresh { place = { 'statusline' }, force = true }
          end)
        end
      end)
    end, { silent = true, desc = 'Choose LLM model' })
  end,
}
