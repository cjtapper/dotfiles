return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      opt = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
      config = true
    }
  },
  config = function ()
    require("copilot_cmp").setup()
  end,
}
