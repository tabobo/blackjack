require 'pry'
class Interface

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
    puts 'Your bet was 10$'
    puts '------------------------------' 
  end

  def choice
    puts '1 - Hit?' if @player.hand.cards.size < 3
    puts '2 - Stand?'
    puts '3 - Open cards?'
    puts '------------------------------'
  end

  # def show_cards
  #   puts '------------------'
  #   puts "Players cards:"
  #   list_cards(@player)
  #   puts "Players score: #{points(@player)}"
  #   puts '------------------'
  #   puts "Dealers cards:"
  #   list_cards(@dealer)
  #   puts "Dealers score: #{points(@dealer)}"
  #   puts '------------------'
  # end

  def show_cards(player)
    puts '------------------'
    puts "Players cards:" if player == @player
    puts "Dealers cards:" if player == @dealer
    list_cards(player)
    puts "Score: #{points(player)}"
    puts '------------------'
  end

  def ask_name
    puts 'Enter your name: '
    @player_name = gets.chomp
  end

  def points(player)
      player.hand.hand_value
    end

  def list_cards(player)
    puts player.hand.cards.map(&:name).join(', ')
  end

  # def list_cards
  #   @player.hand.cards.each_with_index { |card, i| puts "Your card #{i + 1}. #{card.name}" }
  # end

  def show_results(winner)
    puts "You beat the dealer! Your balance: #{@player.bank.balance}" if winner == @player
    puts "Dealer wins. Dealer balance: #{@dealer.bank.balance}. Your balance: #{@player.bank.balance}" if winner == @dealer
    puts "You tied the dealer, nobody wins. Dealer balance: #{@dealer.bank.balance}. Your balance: #{@player.bank.balance}" if winner.nil?
  end

  def new_game?
    puts 'Another game?'
    puts 'y = yes, n = no'
    gets.chomp == 'y'
  end

  def player_bankrupt?(player)
    
    puts "Player doesn't have money"
  end

end

