class HoneymoonPaymentsController < ApplicationController

  def index
    redirect_to new_honeymoon_payment_path
  end

  def new
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