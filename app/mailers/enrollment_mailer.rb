# app/mailers/enrollment_mailer.rb
class EnrollmentMailer < ApplicationMailer
  default from: "Enrollments <no-reply@yourdomain.com>"

  def notify_admin
    @form = params[:form]
    mail to: "mpetriella@ignitexds.com",
         subject: "New Enrollment: #{@form.full_name}"
  end

  def confirm_user
    @form = params[:form]
    mail to: @form.email,
         reply_to: "support@yourdomain.com",
         subject: "We received your enrollment"
  end
end