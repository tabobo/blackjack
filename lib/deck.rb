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
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, Card::JACK, Card::QUEEN, Card::KING, Card::ACE]
    suits = %w[♠ ♥ ♣ ♦]
    suits.each do |suit|
      ranks.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
  end
end
