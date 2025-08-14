class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      puts "Sending email..."
      context = params.dig(:contact, :context).to_s
      subject =
        case context
        when "wlcr_millage" then "New WLCR Millage Form Message"
        else                      "New Contact Form Message"
        end
      ContactMailer.contact_email(@contact, subject: subject).deliver_now
      redirect_back fallback_location: root_path, notice: 'Message sent successfully.'
    else
      flash[:alert] = 'Please fill in all fields correctly.'
      redirect_back fallback_location: root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :context)
  end
end
