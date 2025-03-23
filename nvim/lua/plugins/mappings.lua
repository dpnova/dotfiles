return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
          n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>fr"] = { "<cmd>:Neotree reveal<cr>", desc = "Reveal file" },
          }
        }
      }
    }
  }

