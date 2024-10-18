class Context::PaymentCalculationContext
  def initialize(rent_frequency, rent, rent_changes)
    @rent_frequency = rent_frequency
    @rent = rent
    @rent_changes = rent_changes
  end

  def execute_calculation
    @rent_frequency.calculate(@rent, @rent_changes)
  end
end