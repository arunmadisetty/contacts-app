class ContactsController < ApplicationController
  
  def index
    if current_user
      search = params[:search_term]
      if search
        @contacts = current_user.contacts.where("first_name ILIKE ? OR last_name ILIKE ?", "%" + search + "%")
      else 
        @contacts = current_user.contacts.all
      end

      group_name = params[:group]
      if group_name
        group = Group.find_by(name: group_name)
        @contacts = group.contacts
      end

      render "index.html.erb"

    else
      redirect_to "/login"
    end
  end

  def new
    render "new.html.erb"
  end

  def create
    newcontact = Contact.create(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      user_id: current_user.id
      )
    #render "create.html.erb"
    flash[:success]="New contact added."
    redirect_to "/contacts"
  end

  def show
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    render "show.html.erb"
  end

  def edit
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    render "edit.html.erb"
  end

  def update
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.first_name = params[:first_name]
    @contact.middle_name = params[:middle_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.phone_number = params[:phone_number]
    @contact.bio = params[:bio]
    @contact.save
    #render "update.html.erb"
    flash[:success]="Contact successfully updated."
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.destroy
    #render "destroy.html.erb"
    flash[:danger]="Contact deleted."
    redirect_to "/contacts"
  end
end
