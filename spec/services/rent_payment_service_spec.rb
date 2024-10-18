require 'rails_helper'

describe RentPaymentService do

  subject(:rent_payment_service) { service.execute }

  let(:service) { described_class.new(rent_params, rent_changes_params) }
  let(:rent_changes_params) { {} }
  let(:rent_frequency) { 'weekly' }
  let(:payment_method) { nil }
  let(:rent_params) do
    {
      rent_amount: 900,
      rent_frequency:,
      rent_start_date: '2024-03-01',
      rent_end_date: '2024-05-01',
      payment_method:
    }
  end

  describe '#execute' do
    context 'when rent has no changes' do
      context 'when the rent frequency is WEEKLY' do
        it 'returns 9 dates of payments' do
          expected_payment_dates = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-03-08", payment_method: nil},
            {amount: 900, date: "2024-03-15", payment_method: nil},
            {amount: 900, date: "2024-03-22", payment_method: nil},
            {amount: 900, date: "2024-03-29", payment_method: nil},
            {amount: 900, date: "2024-04-05", payment_method: nil},
            {amount: 900, date: "2024-04-12", payment_method: nil},
            {amount: 900, date: "2024-04-19", payment_method: nil},
            {amount: 900, date: "2024-04-26", payment_method: nil}
          ]
          expect(rent_payment_service).to eq expected_payment_dates
        end
      end

      context 'when the rent frequency is FORTNIGHTLY' do
        let(:rent_frequency) { 'fortnightly' }

        it 'returns 5 dates of payments' do
          expected_payment_dates = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-03-15", payment_method: nil},
            {amount: 900, date: "2024-03-29", payment_method: nil},
            {amount: 900, date: "2024-04-12", payment_method: nil},
            {amount: 900, date: "2024-04-26", payment_method: nil}
          ]
          expect(rent_payment_service).to eq expected_payment_dates
        end
      end

      context 'when the rent frequency is MONTHLY' do
        let(:rent_frequency) { 'monthly' }

        it 'returns 3 dates of payments' do
          expected_payment_dates = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-04-01", payment_method: nil}
          ]
          expect(rent_payment_service).to eq expected_payment_dates
        end
      end
    end

    context 'when rent amount has changes' do
      let(:rent_changes_params) do
        {
          change_amount: 7000,
          effective_at: '2024-04-06'
        }
      end

      context 'when the rent frequency is WEEKLY' do
        it 'returns 9 dates of payments with the relevant rent amount ' do

          expected_payment_dates_with_amount = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-03-08", payment_method: nil},
            {amount: 900, date: "2024-03-15", payment_method: nil},
            {amount: 900, date: "2024-03-22", payment_method: nil},
            {amount: 900, date: "2024-03-29", payment_method: nil},
            {amount: 900, date: "2024-04-05", payment_method: nil},
            {amount: 7000, date: "2024-04-12", payment_method: nil},
            {amount: 7000, date: "2024-04-19", payment_method: nil},
            {amount: 7000, date: "2024-04-26", payment_method: nil}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end

      context 'when the rent frequency is FORTNIGHTLY' do
        let(:rent_frequency) { 'fortnightly' }

        it 'returns 5 dates of payments with the relevant rent amount ' do
          expected_payment_dates_with_amount = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-03-15", payment_method: nil},
            {amount: 900, date: "2024-03-29", payment_method: nil},
            {amount: 7000, date: "2024-04-12", payment_method: nil},
            {amount: 7000, date: "2024-04-26", payment_method: nil}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end

      context 'when the rent frequency is MONTHLY' do
        let(:rent_frequency) { 'monthly' }

        it 'returns 3 dates of payments with the relevant rent amount ' do

          expected_payment_dates_with_amount = [
            {amount: 900, date: "2024-03-01", payment_method: nil},
            {amount: 900, date: "2024-04-01", payment_method: nil}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end
    end

    context 'when payment method is present' do
      context 'when payment method is credit card' do
        let(:payment_method) { 'Credit Card' }
        let(:rent_frequency) { 'monthly' }

        it 'returns 3 dates of payments with 2 days of process at the end of payment date' do

          expected_payment_dates_with_amount= [
            {amount: 900, date: "2024-03-03", payment_method: "Credit Card"},
            {amount: 900, date: "2024-04-03", payment_method: "Credit Card"}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end

      context 'when payment method is bank transfer' do
        let(:payment_method) { 'Bank Transfer' }
        let(:rent_frequency) { 'monthly' }

        it 'returns 3 dates of payments with 3 days of process at the end of payment date' do

          expected_payment_dates_with_amount= [
            {amount: 900, date: "2024-03-04", payment_method: "Bank Transfer"},
            {amount: 900, date: "2024-04-04", payment_method: "Bank Transfer"}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end

      context 'when payment method is instant' do
        let(:payment_method) { 'Instant' }
        let(:rent_frequency) { 'monthly' }

        it 'returns 3 dates of payments with 3 days of process at the end of payment date' do

          expected_payment_dates_with_amount= [
            {amount: 900, date: "2024-03-01", payment_method: "Instant"},
            {amount: 900, date: "2024-04-01", payment_method: "Instant"}
          ]

          expect(rent_payment_service).to eq expected_payment_dates_with_amount
        end
      end
    end
  end


end