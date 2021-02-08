class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    NotificationMailer.send_confirm_to_user(@user).deliver
  end

end