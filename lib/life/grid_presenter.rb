module Life
  class GridPresenter
    attr_reader :grid

    def initialize(grid)
      @grid = grid
    end

    def present
      system 'clear'
      puts self
      sleep 0.5
    end

    def to_s
      [].tap do |s|
        s << border
        grid.cells.each do |row|
          s << Row.new(row) << border
        end
      end.join("\n")
    end

  private

    def border
      @border ||= Border.new(grid.width)
    end

    class Border
      attr_reader :width

      def initialize(width)
        @width = width
      end

      def to_s
        '-' * (width * 4 + 1)
      end
    end

    class Row
      attr_reader :cells

      def initialize(cells)
        @cells = cells
      end

      def to_s
        cells.map { |cell| "| #{cell} " }.join << '|'
      end
    end
  end
end
