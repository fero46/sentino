module Sentino
  class Distance

    def initialize(reference)
      @reference = reference
    end

    def match(string)
      check(string)
    end

private

    def check(string)
      result = levenshtein(@reference, string)
      return result
    end


    def levenshtein(first, second)
      matrix = [(0..first.length).to_a]
      (1..second.length).each do |j|
        matrix << [j] + [0] * (first.length)
      end

      (1..second.length).each do |i|
        (1..first.length).each do |j|
          if first[j-1] == second[i-1]
            matrix[i][j] = matrix[i-1][j-1]
          else
            matrix[i][j] = [
              matrix[i-1][j],
              matrix[i][j-1],
              matrix[i-1][j-1],
            ].min + 1
          end
        end
      end
      return matrix.last.last
    end
  end
end
