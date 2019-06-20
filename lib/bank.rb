class Bank
  attr_reader :balance

  def initialize(balance = 100)
    @balance = balance
  end

  def bet(amount = 10)
    @balance -= amount
  end

  def reward(amount)
    @balance += amount
  end

  def zero_balance?
    @balance <= 0
  end
end
