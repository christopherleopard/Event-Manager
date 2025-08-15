# app/mailers/enrollment_mailer.rb
class EnrollmentMailer < ApplicationMailer
  default from: "Enrollments <no-reply@wlps.net>"

  def notify_admin
    @form = params[:form]
    mail to: "mpetriella@ignitexds.com",
         subject: "New Enrollment: #{@form.full_name}"
  end
end