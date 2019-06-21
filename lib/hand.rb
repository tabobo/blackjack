class Hand
  CARDS_MAX_AMOUNT = 3
  BLACK_JACK = 21

  attr_reader :card, :deck, :cards

  def initialize(_cards)
    @cards = []
  end

  def take_card(deck)
    card = deck.random_card
    deck.delete_card(card)
    new_card(card)
  end

  def new_card(card)
    @cards << card
  end

  def hand_value
    points_sum = @cards.sum(&:value)
    if points_sum > BLACK_JACK
      @cards.sum(&:count_ace)
    else
      points_sum
    end
  end

  def bust?
    hand_value > BLACK_JACK
  end
end
