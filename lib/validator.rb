class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    if valid?(columns) && valid?(rows) && valid?(subgroups)
      return 'Sudoku is valid but incomplete.' if @puzzle_string.include?('0')

      'Sudoku is valid.'
    else
      'Sudoku is invalid.'
    end
  end

  def valid?(arrays)
    arrays.map do |array|
      array.delete(0)
      array.uniq.length == array.length and array.map do |elem|
        elem < 10 and elem.positive?
      end.all?
    end.all?
  end

  def rows
    @puzzle_string.scan(/\d+/).map(&:to_i).each_slice(9).to_a
  end

  def columns
    rows.transpose
  end

  def subgroups
    array = []
    (0..rows.length - 1).step(3).each do |row|
      (0..rows[row].length - 1).step(3).each do |elem|
        array.push([rows[row][elem], rows[row][elem + 1], rows[row][elem + 2],
                    rows[row + 1][elem], rows[row + 1][elem + 1], rows[row + 1][elem + 2],
                    rows[row + 2][elem], rows[row + 2][elem + 1], rows[row + 2][elem + 2]])
      end
    end
    array
  end
end
