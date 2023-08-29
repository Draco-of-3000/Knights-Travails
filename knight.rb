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
end