require_relative './deck'

class Card
  attr_reader :suit, :value, :rank
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  PICTURES = %w[JACK QUEEN KING].freeze
  NUMBERS = %w[2 3 4 5 6 7 8 9 10].freeze
  ACE = 'ACE'
  RANKS = [PICTURES, NUMBERS, ACE].flatten

  ACE_MIN_VALUE = 1
  ACE_MAX_VALUE = 11
  PIC_VALUE = 10
  
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

  private

  def calculate_value(rank)
    case rank
    when ACE then ACE_MAX_VALUE
    when PICTURES.detect { |item| rank == item } then PIC_VALUE
    else rank.to_i
    end
  end
end
