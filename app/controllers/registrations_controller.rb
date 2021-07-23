class RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(_resource)
    home_dashboard_path
  end

  def after_inactive_sign_up_path_for(_resource)
    flash[:notice] = 'Account has been successfully created.'
    home_dashboard_path
  end

  def update_resource(resource, params) # new
    resource.update_without_password(params)
  end

  def update_without_password(params, *options) # new
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
  
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
