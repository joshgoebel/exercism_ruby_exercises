module SavingsAccount
  def self.interest_rate(balance)
    return -3.213 if balance.negative?
    return 2.475 if balance >= 5000
    return 1.621 if balance >= 1000

    # default for accounts < 1000 dollars
    return 0.5
  end

  def self.annual_balance_update(balance)
    balance + (balance.abs * interest_rate(balance) / 100)
  end

  def self.years_before_desired_balance(balance, desired_balance)
    years = 0
    while balance < desired_balance
      balance = annual_balance_update(balance)
      years += 1
    end
    years
    # (0...).find do |year|
    #   # puts year
    #   # puts "balance: #{balance}   desired: #{desired_balance}"
    #   (balance >= desired_balance).tap do
    #     balance = annual_balance_update(balance)
    #   end
    # end
  end
end
