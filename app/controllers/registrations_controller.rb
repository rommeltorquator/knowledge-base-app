class RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(_resource)
    # puts 'this is happening yoyo mama'
    # flash[:notice] = "Account succesfully updated"
    home_dashboard_path
  end

  def after_inactive_sign_up_path_for(_resource)
    flash[:notice] = "Account has been successfully created."
    home_dashboard_path
  end
end
