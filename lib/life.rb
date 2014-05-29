# At each step in time, the following transitions occur:
#
# - Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# - Any live cell with two or three live neighbours lives on to the next generation.
# - Any live cell with more than three live neighbours dies, as if by overcrowding.
# - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

require 'json'

require 'life/grid'
require 'life/grid_presenter'
require 'life/cell'
require 'life/dead_cell'
require 'life/live_cell'

module Life
  def self.load(path)
    config = JSON.parse(File.read(path))

    Grid.new(config['width'], config['height']).tap do |grid|
      grid.seed(config['seeds'])
    end
  end
end
