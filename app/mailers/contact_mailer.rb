class ContactMailer < ApplicationMailer
  default to: 'mpetriella@ignitexds.com'

  def contact_email(contact)
    @contact = contact
    mail(from: @contact.email, subject: 'New Contact Form Message')
  end
end