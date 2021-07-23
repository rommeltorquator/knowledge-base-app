class RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(_resource)
    home_dashboard_path
  end

  def after_inactive_sign_up_path_for(_resource)
    flash[:notice] = 'Account has been successfully created.'
    home_dashboard_path
  end

  # new
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # new
  def update_without_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
