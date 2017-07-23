class Contact < ApplicationRecord
  belongs_to :user
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def japanese_prefix
    "+81 " + phone_number
  end
end
