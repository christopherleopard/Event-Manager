# app/controllers/funds_controller.rb
class FundsController < ApplicationController
  def new
    @fund = FundForm.new
  end

  def create
    @fund = FundForm.new(fund_params)

    if @fund.valid?
      FundMailer.with(form: @fund).notify_admin.deliver_now
      redirect_to new_fund_path, notice: "Thanks! We'll be in touch."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def fund_params
    params.require(:fund_form).permit(:first_name, :last_name, :email, :phone, :message, :trap)
  end
end
