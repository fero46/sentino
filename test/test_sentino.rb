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

  should "give a higher value for baby then for tee" do
    reference = "Babyprodukte / Babynahrung / Kekse & Tee / Babynahrung ab 4. Monat"
    tee = "Geträn­ke Kaffee & Tee Tee Grüner & weißer Tee Weißer Tee"
    baby = "Baby Babynahrung Kindersnacks Babykekse"
    sentino = Sentino::Pattern.new(reference)
    assert_true sentino.match(tee) < sentino.match(baby)
  end

  should "give a higher value for suger then for obst" do
    reference = "Nahrungsmittel / Zucker & Süßstoff / Süßstoff / Süßstoff"
    obst = "Obst & Gemüse Gemüse Zwiebeln & Knoblauch Zwiebeln"
    suger = "Lebens­mittel Mehl Stärke & Co. Zucker & Süße Süßstoff"
    sentino = Sentino::Pattern.new(reference)
    assert_true sentino.match(obst) < sentino.match(suger)
  end

  should "give a higher value for roggen then for mohn" do
    reference = "Brot, Cerealien & Backwaren > Mehl, Getreide & Backzutaten > Getreide > Pseudogetreide > Quinoa"
    mohn = "Baby Babynahrung Beikost Obst & Getreide"
    roggen = "Lebens­mittel Mehl Stärke & Co. Mehl & Getreide Roggenmehl"
    sentino = Sentino::Pattern.new(reference)
    assert_true sentino.match(mohn) < sentino.match(roggen)
  end

  should "give 1 for carrot and carrrot" do
    reference = "carrot"
    test_string = "carrrot"
    sentino = Sentino::Distance.new(reference)
    assert_equal 1, sentino.match(test_string)

  end

  should "give a smaller distance for roggen then for mohn" do
    reference = "Brot, Cerealien & Backwaren > Mehl, Getreide & Backzutaten > Getreide > Pseudogetreide > Quinoa"
    baby = "Baby Babynahrung Beikost Obst & Getreide"
    roggen = "Lebens­mittel Mehl Stärke & Co. Mehl & Getreide Roggenmehl"
    sentino = Sentino::Distance.new(reference)
    assert_true sentino.match(baby) > sentino.match(roggen)
  end


end
