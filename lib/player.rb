class Player
  attr_reader :cards, :bank
  attr_accessor :hand
  
  def initialize
    @cards = []
    @bank = Bank.new
    @hand = Hand.new(@cards)
  end

  def new_card(card)
    @cards << card
  end

  def reset_cards
    @cards = []
    @hand = Hand.new(@cards)
  end

end