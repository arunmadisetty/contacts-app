class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

  
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
