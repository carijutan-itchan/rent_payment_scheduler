# Rend Payment Scheduler

## Goal description
Build a Ruby class that processes rent payment schedules, handles rent changes over time, 
and incorporates different payment methods with varying processing times. 

Create a ruby class that accepts an input object called rent containing the following
information:
- rent_amount (Use the currency of your choice)
- rent_frequency (weekly, fortnightly, or monthly)
- rent_start_date
- rent_end_date

Extend the application to handle rent changes. The application should now accept a new input
object called rent_change with the following details:

- rent_amount
- effective_date (The date when the new rent amount starts to apply)

When a rent change is received, the class should:

1. Recalculate the rent payment dates.
2. Apply the new rent amount from the effective date.
3. Handle multiple rent changes and ensure the recalculated rent payment dates reflect the
correct rent amount at each point in time.
4. Return an array of rent payment dates and their respective rent amount

Adding a new field called payment_method to the rent object. The payment method can be
one of the following:

- credit_card (Takes 2 days to process)
- bank_transfer (Takes 3 days to process)
- instant(Immediate)

The application should return the payment date for each rent based on the processing time of
the selected payment method.

## About the application
The application highlights the following:
- Unit testing using rspec
- Validations
- Strategy Pattern for the implementation of payment calculation
- Response is in Array of Objects format
- Implementation of Hotiwire/Stimulus JS

## Instruction
1. Fork this repository
2. Clone the forked repository
3. Go to root directory of cloned repo and run `bin/dev`
4. Access the app through `http://localhost:3000/`
