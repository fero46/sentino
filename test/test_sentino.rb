require 'helper'

class TestSentino < Test::Unit::TestCase

  should "should give 1.0 for identical String" do
    reference = "Der erste String Test"
    target_1 = reference
    sentino = Sentino::Word.new(reference)
    assert_equal 1.0, sentino.match(target_1)
  end

  should "should give 75 % identical Words" do 
    reference = "Der erste String Test"
    target_1 = reference.gsub("erste", "zweite")
    sentino = Sentino::Word.new(reference)
    assert_equal 0.75, sentino.match(target_1)

  end

end
