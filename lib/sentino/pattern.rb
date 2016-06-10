module Sentino
  class Pattern
    def initialize(reference)
      @reference = prepare_string(reference)
    end

    def match(string)
      check(string)
    end


private
    def prepare_string(string)
      words = string.split(" ").map{|s| s.downcase}
      matchings = []
      for word in words
        matchings += create_matchings(word) if word.length > 3
      end
      matchings
    end

    def create_matchings(word, start=0, word_length=4)
      list = []
      max_length = word.length
      return list if max_length < 4
      if word_length == max_length
        return [word]
      elsif word_length + start < max_length
        list << word[start..word_length-1+start]
        list+=create_matchings(word, start+1, word_length)
      elsif word_length + start == max_length
        list << word[start..word_length-1+start]
        list+=create_matchings(word, 0, word_length+1)
      end
      return list
    end

    def check(string)
      counts = []
      for mathcer in @reference
        counts << count_matchings(string, mathcer)
      end
      total_length = counts.map{|x| x == 0 ? 1 : x}.reduce(:+)
      matching_length = counts.reduce(:+)
      matching_length.to_f/total_length.to_f
    end

    def count_matchings(string, substring)
      string.scan(/(?=#{Regexp.quote(substring)})/).count
    end

  end
end
