module Life
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
      cells.fetch(y).fetch(x)
    rescue IndexError
      DeadCell.new(self, x, y)
    end

    def run
      loop do
        presenter.present
        step
      end
    end

  private

    def presenter
      @presenter ||= GridPresenter.new(self)
    end

    def step
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
end
