# app/mailers/bond_mailer.rb
class FundMailer < ApplicationMailer
  default from: "Bond Form <no-reply@wlps.net>"

  def notify_admin
    @form = params[:form]
    mail to: "createworldleopard@gmail.com, mpetriella@ignitexds.com",
         subject: "New 2024 Sinking Fund Submission: #{@form.full_name}"
  end
end
