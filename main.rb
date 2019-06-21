require_relative 'lib/player'
require_relative 'lib/card'
require_relative 'lib/bank'
require_relative 'lib/deck'
require_relative 'lib/interface'
require_relative 'lib/hand'
require_relative 'lib/dealer'

class Main
  attr_reader :player, :dealer, :deck
  BET_AMOUNT = 10

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @players = [@player, @dealer]
    @interface = Interface.new(@player, @dealer)
    @bank = 0
  end

  def start_game # rubocop:disable Metrics/MethodLength
    @interface.ask_name
    loop do
      @players.each(&:reset_cards)
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
      break if @open_cards || (@dealer.hand.cards.size == Hand::CARDS_MAX_AMOUNT && @player.hand.cards.size == Hand::CARDS_MAX_AMOUNT)
    end
    open_cards unless @open_cards
  end

  def players_turn # rubocop:disable Metrics/MethodLength
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
      raise 'Wrong input'
    end
  rescue StandardError => e
    print_error_message e.message
    retry
  end

  def dealers_turn
    puts 'Dealers turn:'
    if @dealer.hand.hand_value < 17 && @dealer.hand.cards.size < Hand::CARDS_MAX_AMOUNT
      @dealer.hand.take_card(@deck)
      puts 'Dealer hits'
    elsif @dealer.hand.hand_value == Hand::BLACK_JACK
      puts 'Black Jack!'
    else
      puts 'Dealer Stands!'
    end
  end

  def count_results
    d_points = @dealer.hand.hand_value
    p_points = @player.hand.hand_value
    return nil if (@player.hand.bust? && @dealer.hand.bust?) || d_points == p_points
    return @player if @dealer.hand.bust? || (p_points > d_points && p_points <= Hand::BLACK_JACK)
    return @dealer if @player.hand.bust? || d_points > p_points
  end

  def reward(winner)
    if winner.nil?
      @players.each { |player| player.bank.reward(@bank / 2) }
    else
      winner.bank.reward(@bank)
    end
    @bank = 0
  end

  def print_error_message(msg)
    warn "Error: #{msg}"
  end

  def bet
    @players.each do |player|
      player.bank.bet(BET_AMOUNT)
      @bank += BET_AMOUNT
    end
  end

  def open_cards
    puts 'Open cards'
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
