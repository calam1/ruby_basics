class TestCardBuilder
  attr_accessor :cards

  def initialize
    @cards = Array.new 
    @number_cards = Array.new 
    @face_cards = Array.new 
    @suits= Array.new %w[club diamond heart spade]
    @face = Array.new %w[king, queen, jack, ace]

    @suits.each do |suit|
      (2..10).each {|index| @number_cards << "#{index}-#{suit}"}
      @face.each {|royal| @face_cards << "#{royal}-#{suit}"}
    end

    @cards.concat @number_cards
    @cards.concat @face_cards
  end

end

test = TestCardBuilder.new

puts "concat : #{test.cards}"
puts "count: #{test.cards.size}"
