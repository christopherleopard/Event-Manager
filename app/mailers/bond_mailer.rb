# app/mailers/bond_mailer.rb
class BondMailer < ApplicationMailer
  default from: "Bond Form <no-reply@yourdomain.com>"

  def notify_admin
    @form = params[:form]
    mail to: "createworldleopard@gmail.com, mpetriella@ignitexds.com",
         subject: "New Bond Form Submission: #{@form.full_name}"
  end

  def confirm_user
    @form = params[:form]
    mail to: @form.email,
         reply_to: "support@yourdomain.com",
         subject: "We received your submission"
  end
end
