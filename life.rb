# At each step in time, the following transitions occur:
#
# - Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# - Any live cell with two or three live neighbours lives on to the next generation.
# - Any live cell with more than three live neighbours dies, as if by overcrowding.
# - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

module Life
  class Grid
    attr_reader :cells

    def initialize(width, height)
      @cells = Array.new(width) do |x|
        Array.new(height) do |y|
          DeadCell.new
        end
      end
    end

    def seed(*coordinates)
      coordinates.each do |coordinate|
        cells[coordinate[0]][coordinate[1]] = LiveCell.new
      end
    end

    def run
      puts self
    end

    def to_s
      cells.map(&:join).join("\n")
    end
  end

  class DeadCell
    def to_s
      ' '
    end
  end

  class LiveCell
    def to_s
      '*'
    end
  end
end


### Main ###


grid = Life::Grid.new(4, 4)
grid.seed([1, 1], [1, 2], [2, 1], [2, 2])
grid.run
