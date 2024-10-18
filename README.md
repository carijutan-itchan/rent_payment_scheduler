# Rend Payment Scheduler

## Goal description
Build a Ruby class that processes rent payment schedules, handles rent changes over time, 
and incorporates different payment methods with varying processing times. 

The payment method can be one of the following:

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
3. Go to root directory of cloned repo and run ` rails db:seed` and `bin/dev`
4. Access the app through `http://localhost:3000/`
