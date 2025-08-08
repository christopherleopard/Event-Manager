class ContactMailer < ApplicationMailer
  default to: 'createworldleopard@gmail.com'

  def contact_email(contact)
    @contact = contact
    mail(from: @contact.email, subject: 'New Contact Form Message')
  end
end