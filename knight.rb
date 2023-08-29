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

            if current_position == destination_square
                return {
                    moves: path.length - 1,
                    path: path.map(&:position)
                }
            end

            valid_moves(current_position).each do |move|
                next if visited.include?(move)

                new_path = path + [Knight.new(move)]
                queue << new_path
                visited << move
            end
        end
        nil
    end

    private

    def valid_moves(position)
        x, y = position
        moves = [
            [x + 1, y + 2], [x + 2, y + 1],
            [x - 1, y + 2], [x - 2, y + 1],
            [x + 1, y - 2], [x + 2, y - 1],
            [x - 1, y - 2], [x - 2, y - 1]
        ]

        moves.select do |move|
            move[0].between?(0, 7) && move[1].between?(0, 7)
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
knight = Knight.new([3, 3])
chess_board.place_knight(knight, knight.position)

chess_board.display

# Test the knight_moves function
start = [3,3]
destination = [4,3]
result = chess_board.knight_moves(start, destination)

if result
  puts "You made it in #{result[:moves]} moves! Here's your path:"
  result[:path].each { |position| puts position.inspect }
else
  puts "No valid path found."
end