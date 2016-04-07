module Sentino
  class Word

    def initialize(reference)
      @reference = prepare_string(reference)
    end

    def match(string)
      splitted_array = prepare_string(string)
      check(splitted_array)
    end

private
    def prepare_string(string)
      string.split(" ").map{|s| s.downcase}
    end

    def check(input_array)
      hash = {}
      for array in [@reference, input_array]
        for element in array
          if hash[element] == nil
            hash[element]=0
          end
          hash[element]+=1
        end
      end
      analyze = hash.map{|k,v| v}
      total_length = analyze.map{|x| x == 0 ? 1 : x}.reduce(:+)
      matching_length = analyze.map{|x| x == 1 ? 0 : x}.reduce(:+)
      matching_length.to_f/total_length.to_f
    end


  end
end
