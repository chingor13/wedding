class HoneymoonPayment < ActiveRecord::Base

  attr_accessor :card
  validates :amount, numericality: {only_integer: true}, presence: true
  validates :card, presence: true, on: :create

  around_save :charge_stripe, on: :create

  protected

  def charge_stripe
    charge = Stripe::Charge.create({
      amount: amount * 100,
      currency: "usd",
      card: card,
      description: "description"
    })
    if charge.id
      self.charge_identifier = charge.id
      yield
    else
      errors.add(:card, :invalid)
      return false
    end
  end

end
