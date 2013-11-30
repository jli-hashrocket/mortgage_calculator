
class HomePurchaseOption
  def initialize(file, homes=[])
    @file = file
    @homes = homes
  end

  def parse
    CSV.foreach(@file, :headers=>true) do |home|
      @homes << home
    end
  end
  #the amount of cash value you have in the home
  #This would be difference in your property's value
  #and your mortgage balance
  def equity_after_sale
    @homes.each do |home|
      home["Equity"] =  home["Property Value"].to_f.round(2) - home["Mortgage"].to_f.round(2)
    end
  end

  #the amount of money you must borrow to purchase the home
  def required_mortgage
    @homes.each do |home|
      home["Mortgage"] = home["Selling Price"].to_f.round(2) - home["Down Payment"].to_f.round(2)
    end
  end

  #how much your insurance cost will cost over `years` years
  def insurance_cost(years)
    @years = years
    @homes.each do |home|
      home["Insurance Cost"] = (home["Mortgage"] * 0.005) * @years
    end
  end

  def results
    @homes.each do |home|
      puts "*** #{home['Address']} ***"
      puts "Mortgage: #{home['Mortgage']}"
      if pmi_required? == true
        puts "#{@years} of insurance: #{home['Insurance Cost']}"
      else
        puts "#{@years} of insurance: 0"
      end
    end
  end

  private
  #determine if the purchaser must pay insurance
  def pmi_required?
    @homes.each do |home|
      return true if home["Property Value"].to_f.round(2) * 0.20 > home["Equity"]
      return false
    end
  end
end
