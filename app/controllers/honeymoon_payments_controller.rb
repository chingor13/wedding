class HoneymoonPaymentsController < ApplicationController

  def index
  end

  def new
    require_javascript "https://checkout.stripe.com/v2/checkout.js"
    @honeymoon_payment = HoneymoonPayment.new
  end

  def create
    @honeymoon_payment = HoneymoonPayment.new(payment_params)
    if @honeymoon_payment.save
      redirect_to @honeymoon_payment
    else
      render :new
    end
  end

  def show
    @honeymoon_payment = HoneymoonPayment.find(params[:id])
  end

  protected

  def payment_params
    params.require(:honeymoon_payment).permit(:amount, :card)
  end

end