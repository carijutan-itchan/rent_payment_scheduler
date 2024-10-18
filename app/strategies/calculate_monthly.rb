class CalculateMonthly < FrequencyStrategy

  def calculate(rent, rent_changes)
    payment_dates = []

    current_date = Date.parse(rent.rent_start_date)
    end_date = Date.parse(rent.rent_end_date)
  
    while current_date <= end_date

      payment_date = apply_payment_method(current_date, rent.payment_method)

      if rent_changes.present?
        effective_date = Date.parse(rent_changes[:effective_at])
        amount = (current_date <= effective_date ? rent.rent_amount : rent_changes[:change_amount])
        payment_dates << { date: payment_date.strftime("%Y-%m-%d"), amount:, payment_method: rent.payment_method }
      else
        payment_dates << { date: payment_date.strftime("%Y-%m-%d"), amount: rent.rent_amount, payment_method: rent.payment_method }
      end

      break if (current_date >> 1) >= end_date

      next_month = current_date.next_month
      current_date = next_month
    end
  
    payment_dates
  end

  private

  def apply_payment_method(week_end, payment_method)
    case payment_method
    when 'Credit Card'
      week_end + 2.days
    when 'Bank Transfer'
      week_end + 3.days
    else
      week_end
    end
  end
end