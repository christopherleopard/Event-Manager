# app/controllers/bonds_controller.rb
class BondsController < ApplicationController
  def new
    @bond = BondForm.new
  end

  def create
    @bond = BondForm.new(bond_params)

    if @bond.valid?
      BondMailer.with(form: @bond).notify_admin.deliver_now
      redirect_to new_bond_path, notice: "Thanks! We'll be in touch."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bond_params
    params.require(:bond_form).permit(:first_name, :last_name, :email, :phone, :message, :trap)
  end
end
