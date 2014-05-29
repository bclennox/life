module Life
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

    def succ
      self.class.const_get("CellWith#{live_neighbor_count}LiveNeighbors").new(self).succ
    end

    def alive?
      raise NotImplementedError
    end

  private

    def neighbors
      neighbor_coordinates.map do |a, b|
        grid.get(a, b)
      end
    end

    def neighbor_coordinates
      @neighbor_coordinates ||= [
        [x - 1, y - 1],
        [x    , y - 1],
        [x + 1, y - 1],

        [x - 1, y    ],
        [x + 1, y    ],

        [x - 1, y + 1],
        [x    , y + 1],
        [x + 1, y + 1],
      ]
    end

    def live_neighbor_count
      neighbors.count(&:alive?)
    end

    class Successor
      attr_reader :cell

      def initialize(cell)
        @cell = cell
      end
    end
  end
end
