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
        if word.length > 3
          wordgroups = create_matchings(word)
          matchings << wordgroups
        end
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
      checked_words = []
      counts = []
      for words in @reference
        #counts << count_matchings(string, mathcer)
        res = 0
        words = words.sort_by(&:length).reverse
        for word in words
          break if checked_words.include? word
          res = count_matchings(string, word)
          if res > 0
            checked_words << word
            break
          end
        end
        counts << res
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
