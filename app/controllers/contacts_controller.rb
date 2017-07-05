class ContactsController < ApplicationController
  def contacts_method
    @contacts = Contact.all
    @first = Contact.find_by(id: 1)
    @second = Contact.find_by(id: 2)
    @third = Contact.find_by(id: 3)
    render "contacts.html.erb"
  end
end
