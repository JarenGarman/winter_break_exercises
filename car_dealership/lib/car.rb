# frozen_string_literal: true

# TLD
class Car
  attr_reader :make, :model, :monthly_payment, :loan_length, :total_cost

  def initialize(make_and_model, monthly_payment, loan_length)
    @make, @model = make_and_model.split
    @monthly_payment = monthly_payment
    @loan_length = loan_length
    @total_cost = monthly_payment * loan_length
  end
end
