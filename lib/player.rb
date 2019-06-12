class Player
  attr_reader :cards, :balance, :bank
  attr_accessor :hand
  
  def initialize
    @cards = []
    @bank = Bank.new
    @balance = @bank.balance
    @hand = Hand.new(@cards)
  end

  def new_card(card)
    @cards << card
  end

  def bet(amount = 10)
    @balance -= amount
  end

  # def list_cards
  #   @cards.each_with_index { |card, i| puts card.name }
  # end

  def bankrupt?
    @balance.zero?
  end
end