# this is the tictactoe board
class Board
  def initialize
    @board_state = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @player_turn = 'o'
    @end_game = false
    @round_number = 0
  end

  attr_reader :end_game, :letter, :column, :player_turn, :round_number

  def display_board
    puts '-----------'
    puts '   1 2 3'
    puts "a  #{get_board_row(0)}"
    puts "b  #{get_board_row(1)}"
    puts "c  #{get_board_row(2)}"
    puts '-----------'
  end

  def get_board_row(index)
    "#{@board_state[index][0]}|#{@board_state[index][1]}|#{@board_state[index][2]}"
  end

  def good_play?(letter, column)
    good_command = ['a', 'b', 'c'].include?(letter.downcase) && ['1', '2', '3'].include?(column)
    return false unless good_command

    line, column = translate_command(letter, column)
    good_place = @board_state[line][column] == ' '
    good_command && good_place
  end

  def translate_command(letter, column)
    [letter.downcase.ord - 97, column.to_i - 1]
  end

  def mark_play(letter, column)
    @round_number += 1
    line, column = translate_command(letter, column)
    if @player_turn == 'o'
      @board_state[line][column] = 'o'
      @player_turn = 'x'
    elsif @player_turn == 'x'
      @board_state[line][column] = 'x'
      @player_turn = 'o'
    end
  end

  def play
    display_board
    puts "escolha uma jogada: #{@player_turn}"
    play = gets.chomp.chars
    @letter = play[0]
    @column = play[1]
  end

  def index_matrix(symbol)
    @board_state.reduce([]) do |acc, line|
      acc << line.each_index.select { |i| line[i] == symbol }
    end
  end

  def check_line(index_matrix)
    check_column(index_matrix) || check_row(index_matrix)
  end

  def check_row(index_matrix)
    index_matrix.each do |row|
      return true if row.length == 3
    end
    false
  end

  def check_column(index_matrix)
    result = index_matrix.reduce([0, 1, 2]) do |acc, row|
      acc & row
    end
    result != []
  end

  def check_diagonal(index_matrix)
    normal_diagonal = index_matrix[0].include?(0) && index_matrix[1].include?(1) && index_matrix[2].include?(2)
    reverse_diagonal = index_matrix[0].include?(2) && index_matrix[1].include?(1) && index_matrix[2].include?(0)
    normal_diagonal || reverse_diagonal
  end

  def check_end_game
    ['o', 'x'].each do |symbol|
      @end_game = true if check_line(index_matrix(symbol)) || check_diagonal(index_matrix(symbol))
    end
    @end_game = @end_game || @round_number == 9
  end
end
