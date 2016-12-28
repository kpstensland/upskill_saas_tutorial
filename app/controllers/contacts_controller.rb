class ContactsController < ApplicationController
  
  # GET request to /contact-us (custom route)
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts
  def create
    # mass assignment of form fields into contact object
    # note that "@contact = Contact.new" + "@contact.save" is equivalent to "Contact.create"
    @contact = Contact.new(contact_params)
    # save the contact object to the db
    if @contact.save
      # store form fields via parameters into local vars
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]  #should have named "body" as "comments"
      # plug vars into ContactMailer email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # store success message in flash hash
      # and redirect to the new action
      flash[:success] = "Message sent"
      redirect_to new_contact_path
      
    else
      # if Contact object doesn't save,
      # store errors in flash has and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
    # to collect data from form, we need to use strong parameters
    # and whitelist the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end