class Contact < ActiveRecord::Base
  #Contact form validations
  #name, email, comments, created_at, updated_at (pulled from db automatically)
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end