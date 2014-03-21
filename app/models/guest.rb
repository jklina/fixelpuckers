class Guest
  def admin
    false
  end
  alias_method :admin?, :admin

  def username
    ""
  end

  def id
    nil
  end
end
