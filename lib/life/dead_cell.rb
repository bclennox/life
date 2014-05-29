module Life
  class DeadCell < Cell
    def to_s
      ' '
    end

    def alive?
      false
    end

    class LivingSuccessor < Successor
      def succ
        LiveCell.new(cell.grid, cell.x, cell.y)
      end
    end

    class DyingSuccessor < Successor
      def succ
        cell
      end
    end

    CellWith3LiveNeighbors = LivingSuccessor

    CellWith0LiveNeighbors =
    CellWith1LiveNeighbors =
    CellWith2LiveNeighbors =
    CellWith4LiveNeighbors =
    CellWith5LiveNeighbors =
    CellWith6LiveNeighbors =
    CellWith7LiveNeighbors =
    CellWith8LiveNeighbors = DyingSuccessor
  end
end
