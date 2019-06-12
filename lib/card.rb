require_relative './deck'

class Card
  attr_reader :suit, :value, :rank
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = calculate_value(rank)
  end

  def name
    "#{@suit} #{@rank}"
  end

  #private

  def calculate_value(rank)
    case rank
    when 'JACK', 'QUEEN', 'KING' then 10
    when 'ACE' then 11
    else rank.to_i
    end
  end
end