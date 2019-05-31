class Card
  attr_reader :suit, :score, :rank
  
  def initialize(suit, score, rank)
    @suit = suit
    @score = score
    @rank = rank
  end
end