class MoneyDispenser
  def get_withdrawal_options(value)
     options_to_hash(get_options(value))
  end

  private
  def get_bill_combinations(value, bills, current_combination, options)
    rest = value % bills.first
    qty = value / bills.first

    if rest == 0
      current_combination.push({bill: bills.first/100, qty: qty})
      options.push(current_combination)
    else
      return false if bills.length == 1
      current_combination.push({bill: bills.first/100, qty: qty})
      get_bill_combinations(rest, bills.drop(1), current_combination, options)
    end
  end

  def get_options(value)
    bills = [10000, 5000, 2000, 1000]
    current_combination = Array.new
    options = Array.new

    for i in (4).downto(1)
      bills.combination(i).to_a.each do |combination|
        get_bill_combinations value, combination, current_combination, options
        current_combination = Array.new
      end
    end

    options
  end
  
  def options_to_hash(options)
    options_hash = Hash.new
    options.each_with_index {|item, index| options_hash[(index+1).to_s.to_sym] = item}
    options_hash
  end
end