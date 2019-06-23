require_relative './card'

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    create_deck
    @deck.shuffle!
  end

  def random_card
    deck.sample
  end

  def delete_card(card)
    @deck.delete(card)
  end

  private

  def create_deck
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
  end
end
