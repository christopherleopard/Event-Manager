class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      puts "Sending email..."
      ContactMailer.contact_email(@contact).deliver_now
      redirect_back fallback_location: root_path, notice: 'Message sent successfully.'
    else
      flash[:alert] = 'Please fill in all fields correctly.'
      redirect_back fallback_location: root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
