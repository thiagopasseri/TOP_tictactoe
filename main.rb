require_relative 'board'

board = Board.new

until board.end_game
  loop do
    board.play
    break unless board.good_play?(board.letter, board.column)

    board.mark_play(board.letter, board.column)
    next unless board.check_end_game

    if board.round_number == 9
      board.display_board
      puts 'VELHA'
    else
      winner = board.player_turn == 'o' ? 'x' : 'o'
      board.display_board
      puts "#{winner} WINNER!"
    end

    break
  end
end
