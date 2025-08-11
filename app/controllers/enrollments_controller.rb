# app/controllers/enrollments_controller.rb
class EnrollmentsController < ApplicationController
  def new
    @enrollment = EnrollmentForm.new
  end

  def create
    @enrollment = EnrollmentForm.new(enrollment_params)

    if @enrollment.valid?
      EnrollmentMailer.with(form: @enrollment).notify_admin.deliver_later
      EnrollmentMailer.with(form: @enrollment).confirm_user.deliver_later
      redirect_to new_enrollment_path, notice: "Thanks! We’ll be in touch."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def enrollment_params
    params.require(:enrollment_form).permit(
      :first_name, :last_name, :email, :phone,
      :address1, :address2, :city, :state, :zip, :message, :trap
    )
  end
end