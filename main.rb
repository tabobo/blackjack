require_relative 'lib/player'
require_relative 'lib/card'
require_relative 'lib/bank'
require_relative 'lib/deck'
require_relative 'lib/interface'
require_relative 'lib/hand'
require_relative 'lib/dealer'



# Ask player's name
  # Everyone has 100$
    # Initialize deck of cards
      # Deal two random cards each to player and dealer
      # Remove the dealt cards from the deck as they are dealt
        # Everyone gives 10$ to Bank
          # Player 'Hits' or 'Stands' or 'BJ'
            # if player stands play moves to Dealer  
            # if player hits then another card is dealt
            # if total > 21 then player busts and dealer wins and receives Bank, else if 16<score<20 player can 'Hit' or 'Stand', else 'Hit' 
            # Remove dealt cards from deck array
              # continue until 'Stand' or 'Bust'
                # Dealer plays if player 'stands' or has BJ
                  # if dealer cards == BJ && players cards == BJ its a push and everyone has half of Bank
                  # else if dealers cards < 16 dealer 'Hits'
                  # else if dealers cards > 16 && <=21 'Stand'
                  # else bust and player has Bank
                    # Result 
                      # play again?

class Main
  attr_reader :player, :dealer, :deck
  BET_AMOUNT = 40

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @players = [@player, @dealer]
    @interface = Interface.new(@player, @dealer)
    @bank = 0
  end

  def start_game
    @interface.ask_name
    loop do
      @players.each { |player| player.reset_cards }
      deal_cards(player, dealer)
      bet
      break if @players.find { |player| player.bank.zero_balance? }
      @interface.show_table
      @open_cards = false
      play_game
      winner = count_results
      reward(winner)
      @interface.show_results(winner)
      break unless @interface.new_game?
    end
  end

  private


  def play_game
    loop do
      players_turn
      dealers_turn unless @open_cards
      break if @open_cards || (@dealer.hand.cards.size == 3 && @player.hand.cards.size == 3)
    end
    open_cards unless @open_cards
  end

  def players_turn
    @interface.choice
    @choice = gets.chomp.downcase
    if @choice == '1'
      puts 'Player hits'
      @player.hand.take_card(@deck)
      @interface.show_cards(@player)
    elsif @choice == '2'
      puts 'Player stands'
    elsif @choice == '3'
      @open_cards = true
      open_cards
    else
      puts 'Wrong input'
    end
  end

  def dealers_turn
    puts 'dealers turn'
    puts @interface.points(@dealer)
    if @dealer.hand.hand_value < 17 && @dealer.hand.cards.size < 3
      @dealer.hand.take_card(@deck)
      puts 'Dealer hits'
    elsif @dealer.hand.hand_value == 21
      puts 'Black Jack!'
    else
      puts 'Dealer Stands!'
    end
  end

# Проверить. Не работает, когда у игрока больше очков чем у дилера после 21
  def count_results
    d_points = @dealer.hand.hand_value
    p_points = @player.hand.hand_value
    return @player if @dealer.hand.bust? || (p_points > d_points && p_points <= 21)
    return @dealer if @player.hand.bust? || d_points > p_points
    return nil if (@player.hand.bust? && @dealer.hand.bust?) || d_points == p_points
  end

  def reward(winner)
    if winner.nil?
      @players.each { |player| player.bank.reward(@bank / 2.to_f) }
    else
      winner.bank.reward(@bank)
    end
    @bank = 0
  end

  def bet
    @players.each do |player| 
      player.bank.bet(BET_AMOUNT) 
      @bank += BET_AMOUNT
    end
  end

  def open_cards
    puts 'open cards'
    @interface.show_cards(@player)
    @interface.show_cards(@dealer)
  end

  def deal_cards(player, dealer)
    2.times do 
      player.hand.take_card(@deck)
      dealer.hand.take_card(@deck)
    end
  end

end

game = Main.new
game.start_game
