return {
  "folke/snacks.nvim",
  opts = function()
    local dashboard_config = require("config.dashboard")
    return {
      dashboard = dashboard_config.dashboard,
      picker = {
        sources = {
          explorer = {
            layout = { layout = { position = "right" } },
          },
        },
      },
    }
  end,
}
