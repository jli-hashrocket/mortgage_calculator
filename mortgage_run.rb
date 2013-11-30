require 'pry'
require 'csv'
require_relative 'home_purchase_option'



file = "mortgage.csv"
mortgage = HomePurchaseOption.new(file)
mortgage.parse
mortgage.required_mortgage
mortgage.equity_after_sale
mortgage.insurance_cost(2)
mortgage.results
