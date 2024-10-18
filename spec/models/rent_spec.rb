require 'rails_helper'

RSpec.describe Rent do

  describe "#validations" do

    subject(:rent) { described_class.new(attributes:) }

    let(:attributes) do
      {
        rent_amount:,
        rent_frequency:,
        rent_start_date:,
        rent_end_date:,
        payment_method:
      }
    end

    let(:rent_amount) { 1700 }
    let(:rent_frequency) { 'weekly' }
    let(:rent_start_date) { '2024-10-15' }
    let(:rent_end_date) { '2024-10-25' }
    let(:payment_method) { 'Credit Card' }

    context 'when rent has valid attributes' do
      it { expect(rent).to be_valid }
    end

    context 'when rent has invalid attributes' do
      context 'when rent amount is not a number' do
        let(:rent_amount) { 'testnumber' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent amount is not present' do
        let(:rent_amount) { '' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent frequency is not present' do
        let(:rent_frequency) { '' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent frequency is not in frequencies' do
        let(:rent_frequency) { 'test frequency' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent start date is not present' do
        let(:rent_start_date) { '' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent end date is not present' do
        let(:rent_end_date) { '' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent start date is not a valid date' do
        let(:rent_start_date) { 'test123' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent end date is not a valid date' do
        let(:rent_end_date) { 'test1234' }

        it { expect(rent).not_to be_valid }
      end

      context 'when rent start date is after the end date' do
        let(:rent_end_date) { '2024-10-05' }

        it { expect(rent).not_to be_valid }
      end

      context 'when payment method is not valid' do
        let(:payment_method) { 'cash' }

        it { expect(rent).not_to be_valid }
      end
    end
  end
end