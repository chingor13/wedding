class AnonymousUser
  include Singleton

  def name
    "Guest"
  end

  def admin?
    false
  end

  def authenticated?
    false
  end

end