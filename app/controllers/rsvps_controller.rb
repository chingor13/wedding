class RsvpsController < ApplicationController

  before_filter :authorize!, only: [:new, :create, :show]
  before_filter :authorize_as_admin!, only: [:new, :create, :show]
  before_filter :load_rsvp, only: [:show, :reply, :respond]

  def index
    @rsvps = if current_user.admin?
      Rsvp.all
    else
      []
    end

    respond_to do |format|
      format.json
      format.html
    end
  end

  def search
    @rsvps = Rsvp.where(email_address: rsvp_params[:email_address])
  end

  def show
  end

  def reply
  end

  def new
    @rsvp = Rsvp.new
    @rsvp.build_address
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.save
      redirect_to rsvps_path, flash: {success: "Successfully created invite."}
    else
      render :new
    end
  end

  def respond
    @rsvp.responded_at = Time.now
    if @rsvp.update_attributes(reply_params)
      redirect_to registry_path, flash: {success: "Thanks for RSVPing!"}
    else
      render :reply
    end
  end

  protected

  def load_rsvp
    @rsvp = Rsvp.where(code: params[:id]).first
    raise ActiveRecord::RecordNotFound unless @rsvp
  end

  def rsvp_params
    params.require(:rsvp).permit(:name, :email_address, :max_attending, address_attributes: [:line1, :line2, :city, :state, :zip])
  end

  def reply_params
    params.require(:rsvp).permit(:total, :attending, :notes)
  end

end