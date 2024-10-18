class MainController < ApplicationController

  def index; end

  def generate_payment_schedule
    payment_service = RentPaymentService.new(set_rent_params, set_rent_changes_params)
    @response = payment_service.execute

    respond_to do |format|
      if payment_service.errors.present?
        render :index
      else
        format.turbo_stream { render 'generate_payment_schedule' }
      end
    end
  end

  private

  def set_rent_params
    params.permit(:rent_amount, :rent_frequency, :rent_start_date, :rent_end_date, :payment_method)
  end

  def set_rent_changes_params
    if params[:change_amount].present? && params[:effective_at].present?
      params.permit(:change_amount, :effective_at)
    end
  end
end