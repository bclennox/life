# At each step in time, the following transitions occur:
#
# - Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# - Any live cell with two or three live neighbours lives on to the next generation.
# - Any live cell with more than three live neighbours dies, as if by overcrowding.
# - Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

require 'json'

module Life
  def self.load(path)
    config = JSON.parse(File.read(path))

    grid = Grid.new(config['width'], config['height'])
    grid.seed(config['seeds'])

    grid.run
  end

  class Grid
    attr_reader :width, :height, :cells

    def initialize(width, height)
      @width = width
      @height = height

      @cells = generate_cells
    end

    def seed(seeds)
      seeds.each do |seed|
        cells[seed['y']][seed['x']] = LiveCell.new(self, seed['x'], seed['y'])
      end
    end

    def get(x, y)
      if x.between?(0, width - 1) && y.between?(0, height - 1)
        cells[y][x]
      else
        DeadCell.new(self, x, y)
      end
    end

    def run
      5.times do
        puts self
        generate
      end
    end

    def to_s
      cells.map(&:join).join("\n")
    end

  private

    def generate
      new_cells = generate_cells

      cells.each.with_index do |row, y|
        row.each.with_index do |cell, x|
          new_cells[y][x] = cell.succ
        end
      end

      @cells = new_cells
    end

    def generate_cells
      Array.new(height) do |y|
        Array.new(width) do |x|
          DeadCell.new(self, x, y)
        end
      end
    end
  end

  class Cell
    attr_reader :grid, :x, :y

    def initialize(grid, x, y)
      @grid = grid
      @x = x
      @y = y
    end

    def inspect
      "#{self.class}(#{x}, #{y})"
    end

    def neighbors
      coordinates = [
        [x - 1, y - 1],
        [x    , y - 1],
        [x + 1, y - 1],

        [x - 1, y    ],
        [x + 1, y    ],

        [x - 1, y + 1],
        [x    , y + 1],
        [x + 1, y + 1],
      ]

      coordinates.map do |a, b|
        grid.get(a, b)
      end
    end
  end

  class DeadCell < Cell
    def to_s
      ' '
    end

    def succ
      if neighbors.count(&:alive?) == 3
        LiveCell.new(grid, x, y)
      else
        self
      end
    end

    def alive?
      false
    end
  end

  class LiveCell < Cell
    def to_s
      '*'
    end

    def succ
      if neighbors.count(&:alive?).between?(2, 3)
        self
      else
        DeadCell.new(grid, x, y)
      end
    end

    def alive?
      true
    end
  end
end


### Main ###


if ARGV.empty?
  puts "Usage: #{$0} /path/to/config.json"
  exit 1
end

Life.load(ARGV.first)
