class  GameBoard
    attr_reader :board

    def initialize
        @board = Array.new(8) { Array.new(8)}
    end

    def display
        @board.each do |row|
            puts '--------------------------------'
            puts row.map { |piece| piece.nil? ? '   ' : piece.to_s }.join('|')
            puts '--------------------------------'
        end
    end

    def place_knight(knight, position)
        x, y = position
        @board[x][y] = knight
    end
end

class Knight
    attr_accessor :position

    def initialize(position)
        @position = position
    end
    
    def to_s
        '♞'
    end
end

chess_board = GameBoard.new
knight = Knight.new([0, 0])
chess_board.place_knight(knight, knight.position)

chess_board.display
