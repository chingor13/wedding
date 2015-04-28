class Rsvp < ActiveRecord::Base

  scope :responded, -> { where("responded_at IS NOT NULL") }
  scope :attending, -> { where(attending: true) }

  validates :code, presence: true
  validate :attending_number_on_accept
  validates :total, presence: true, numericality: {only_integer: true}
  validates :max_attending, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  before_validation :generate_code, on: :create
  after_create :generate_qr_code

  mount_uploader :qrcode, QrCodeUploader

  has_one :address, class_name: 'Address', as: :owner, inverse_of: :owner
  accepts_nested_attributes_for :address

  def to_param
    code
  end

  def responded?
    responded_at.present?
  end

  protected

  def attending_number_on_accept
    if attending?
      if total < 1
        errors.add(:total, "must be greater than 0") 
      elsif total > max_attending
        errors.add(:total, "must be less than #{max_attending}") 
      end
    end
  end

  def generate_code
    self.code ||= UUID.generate
  end

  def generate_qr_code
    qr = RQRCode::QRCode.new("http://wedding.chingr.com/rsvp/#{code}/reply", size: 8, level: :h )
    blob = qr.to_img.resize(300,300)
    file = Tempfile.new(["qrcode", ".png"])
    file.write(blob.to_blob)
    file.close
    self.qrcode = file
    self.save
    true
  end

end