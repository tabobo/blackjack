class Interface
  BET_AMOUNT = 10

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  def show_table
    puts '--------- BLACK JACK ---------'
    puts "Hello, #{@player_name}!"
    puts 'Your cards:'
    list_cards(@player)
    puts "Your score: #{points(@player)}"
    puts "Balance: #{@player.bank.balance}$"
    puts "Your bet was #{BET_AMOUNT}$"
    puts '------------------------------'
  end

  def choice
    puts '------------------'
    puts 'Your turn:'
    puts '1 - Hit?' if @player.hand.cards.size < 3
    puts '2 - Stand?'
    puts '3 - Open cards?'
    puts '------------------'
  end

  def show_cards(player)
    puts '------------------'
    puts 'Players cards:' if player == @player
    puts 'Dealers cards:' if player == @dealer
    list_cards(player)
    puts "Score: #{points(player)}"
    puts '------------------'
  end

  def ask_name
    puts 'Enter your name: '
    @player_name = gets.chomp
    raise "Name can't be empty!" if @player_name.nil?
    raise 'Name should be at least 3 symbols!' if @player_name.length < 3
  rescue StandardError => e
    print_error_message e.message
    retry
  end

  def points(player)
    player.hand.hand_value
  end

  def list_cards(player)
    puts player.hand.cards.map(&:name).join(', ')
  end

  def show_results(winner) 
    puts "You beat the dealer! Your balance: #{@player.bank.balance}. Dealer balance: #{@dealer.bank.balance}." if winner == @player
    puts "Dealer wins. Dealer balance: #{@dealer.bank.balance}. Your balance: #{@player.bank.balance}" if winner == @dealer
    puts "You tied the dealer, nobody wins. Dealer balance: #{@dealer.bank.balance}. Your balance: #{@player.bank.balance}" if winner.nil?
  end

  def new_game?
    puts 'Another game?'
    puts 'y = yes, n = no'
    answer = gets.chomp
    answer == 'y'
    raise 'Wrong input' unless answer == 'y' || answer == 'n'
  rescue StandardError => e
    print_error_message e.message
    retry
  end

  def player_bankrupt?(_player)
    puts "Player doesn't have money"
  end

  def print_error_message(msg)
    warn "Error: #{msg}"
  end
end
