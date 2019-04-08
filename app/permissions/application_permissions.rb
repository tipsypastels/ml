class ApplicationPermissions
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def no_user?
    user.nil?
  end

  def can_admin?
    user && user.admin?
  end

  def can_moderate?
    user && (user.moderates?(topic.club) || user.admin?)
  end
end