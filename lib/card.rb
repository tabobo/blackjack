require_relative './deck'

class Card
  attr_reader :suit, :value, :rank
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = calculate_value(rank)
  end

  def count_ace
    ace? ? 1 : @value
  end

  def ace?
    @rank == 'ACE'
  end

  def name
    "#{@suit} #{@rank}"
  end

  #private

  def calculate_value(rank)
    case rank
    when 'ACE' then 11
    when 'JACK', 'QUEEN', 'KING' then 10
    else rank.to_i
    end
  end
end