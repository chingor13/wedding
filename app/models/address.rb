class Address < ActiveRecord::Base

  belongs_to :owner, polymorphic: true, inverse_of: :owner

  validates :line1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, format: { with: /\d{5}(-\d{4})?/ }

end