exemplo = [['x','x','o'],['x',' ','x'],['x','o',' ']]

# arr = exemplo.reduce([]) do |acc, line|
#   acc << line.each_index.select { |i| line[i] == 'x'  }
# end
# p arr


def index_matrix(symbol, exemplo)
  arr = exemplo.reduce([]) do |acc, line|
    acc << line.each_index.select { |i| line[i] == symbol  }
  end
end

def check_line(index_matrix)
  result = index_matrix.reduce([0,1,2]) do |acc, line|
    acc & line
  end
end

def check_diagonal(index_matrix)
  normal_diagonal = index[0].include?(0) && index[1].include?(1) && index[2].include?(2) 
  reverse_diagonal = index[0].include?(2) && index[1].include?(1) && index[2].include?(0)
  normal_diagonal || reverse_diagonal
end

arr = index_matrix('x', exemplo)
p arr
p check_line(arr)