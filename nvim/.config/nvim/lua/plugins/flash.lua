return {
  "folke/flash.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
