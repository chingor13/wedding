class RsvpsController < ApplicationController

  before_filter :authorize!, except: [:index, :reply, :respond]
  before_filter :authorize_as_admin!, except: [:index, :reply, :respond]
  before_filter :load_rsvp, only: [:show, :reply, :respond, :edit, :update]

  def index
    @rsvps = if current_user.admin?
      Rsvp.order(:id).to_a
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

  def bulk
    scope = Rsvp.where(id: params[:invite])
    case params[:commit]
    when I18n.t("rsvp.commands.print")
      redirect_to print_rsvps_path(format: :pdf, invite: params[:invite])
    when I18n.t("rsvp.commands.mark_sent")
      scope.update_all(sent: true)
      redirect_to rsvps_path, flash: {success: "Marked selected as sent"}
    when I18n.t("rsvp.commands.mark_unsent")
      scope.update_all(sent: false)
      redirect_to rsvps_path, flash: {success: "Marked selected as unsent"}
    end
  end

  def print
    @rsvps = Rsvp.find(params[:invite])

    respond_to do |format|
      format.pdf
    end
  end

  def show
    respond_to do |format|
      format.pdf
      format.html
    end
  end

  def reply
  end

  def new
    @rsvp = Rsvp.new
    @rsvp.build_address
  end

  def edit
  end

  def update
    if @rsvp.update_attributes(rsvp_params)
      redirect_to @rsvp, flash: {success: "Successfully updated invite."}
    else
      render :edit
    end
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