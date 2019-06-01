require_relative './deck'

class Card
  attr_reader :suit, :score, :rank
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    #@score = calculate_score(rank)
  end

  def name
    "#{@suit} #{@rank}"
  end
end