class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    ThanksMailer.complete_registration(current_user).deliver
  end

end