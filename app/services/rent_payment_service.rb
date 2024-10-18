class RentPaymentService

  attr_reader :rent_params, :rent_changes, :errors

  def initialize(rent_params, rent_changes={})
    @rent_params = rent_params
    @rent_changes = rent_changes
    @errors = []
  end

  def execute
    rent = Rent.new(rent_params)

    response = if rent.valid?
                calculate_payment(rent)
              else
                errors << rent.errors.messages
              end

    response
  end

  private

  def calculate_payment(rent)
    rent_frequency =  case rent.rent_frequency
                      when 'weekly'
                        CalculateWeekly.new
                      when 'fortnightly'
                        CalculateFortnightly.new
                      when 'monthly'
                        CalculateMonthly.new
                      end

    rent_payment_context = Context::PaymentCalculationContext.new(rent_frequency, rent, rent_changes)
    rent_payment_context.execute_calculation
  end
end