class Hand
  CARDS_MAX_AMOUNT = 3

  attr_reader :card, :deck, :cards

  def initialize(cards)
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

  def open_cards
  end

  def hand_value
    # points = 0
    # @cards.each { |card| points += card.value}
    # return points

    points_sum = @cards.sum(&:value)
    if points_sum > 21
      @cards.sum(&:count_ace)
    else
      points_sum
    end
  end

  def bust? 
    hand_value > 21
  end
end