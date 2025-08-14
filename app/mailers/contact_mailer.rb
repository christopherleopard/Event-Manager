class ContactMailer < ApplicationMailer
  default to: 'mpetriella@ignitexds.com, createworldleopard@gmail.com'

  def contact_email(contact, subject: 'New Contact Form Message')
    @contact = contact
    mail(from: @contact.email, subject: subject)
  end
end