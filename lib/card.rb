require_relative './deck'

class Card
  attr_reader :suit, :value, :rank
  
  ACE_MIN_VALUE = 1
  ACE_MAX_VALUE = 11
  PIC_VALUE = 10
  
  ACE = 'ACE'
  JACK = 'JACK'
  QUEEN = 'QUEEN'
  KING = 'KING'
  
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @value = calculate_value(rank)
  end

  def count_ace
    ace? ? ACE_MIN_VALUE : @value
  end

  def ace?
    @rank == ACE
  end

  def name
    "#{@suit} #{@rank}"
  end

  # private

  def calculate_value(rank)
    case rank
    when ACE then ACE_MAX_VALUE
    when JACK, QUEEN, KING then PIC_VALUE
    else rank.to_i
    end
  end
end
