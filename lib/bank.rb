class Bank
  attr_reader :balance
  
  def initialize(balance = 100)
    @balance = balance
  end

  def bet(amount = 10)
    @balance -= amount
  end
end