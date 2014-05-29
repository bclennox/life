module Life
  class LiveCell < Cell
    def to_s
      '*'
    end

    def alive?
      true
    end

    class LivingSuccessor < Successor
      def succ
        cell
      end
    end

    class DyingSuccessor < Successor
      def succ
        DeadCell.new(cell.grid, cell.x, cell.y)
      end
    end

    CellWith2LiveNeighbors =
    CellWith3LiveNeighbors = LivingSuccessor

    CellWith0LiveNeighbors =
    CellWith1LiveNeighbors =
    CellWith4LiveNeighbors =
    CellWith5LiveNeighbors =
    CellWith6LiveNeighbors =
    CellWith7LiveNeighbors =
    CellWith8LiveNeighbors = DyingSuccessor
  end
end
