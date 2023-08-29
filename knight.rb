class GameBoard
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

    def knight_moves(start, destination)
        start_square = start
        destination_square = destination

        queue = [[Knight.new(start_square)]]
        visited = [start_square]

        until queue.empty?
            path = queue.shift
            current_position = path.last.position

            return path.map(&:position) if current_position == destination_square

            valid_moves(current_position).each do |move|
                next if visited.include?(move)

                new_path = path + [Knight.new(move)]
                queue << new_path
                visited << move
            end
        end
    end
end

class Knight
    attr_accessor :position

    def initialize(position)
        @position = position
    end
    
    def to_s
        ' ♞ '
    end
end

chess_board = GameBoard.new
knight = Knight.new([0, 5])
chess_board.place_knight(knight, knight.position)

chess_board.display
