require_relative './card'

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    create_deck
    @deck.shuffle!
  end

  def take_card
    card = self.deck.sample
    @deck.delete(card)
    return card
  end

  private

  def create_deck
    ranks = %w[2 3 4 5 6 7 8 9 10 JACK QUEEN KING ACE]
    suits = %w[♠ ♥ ♣ ♦]
    suits.each do |suit|
      ranks.each do |rank|
        #@deck.push("#{suit} #{rank}")
        @deck << Card.new(suit, rank)
      end
    end
  end
end
