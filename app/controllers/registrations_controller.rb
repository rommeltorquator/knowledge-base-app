class RegistrationsController < Devise::RegistrationsController
  protected
  def after_update_path_for(resource)
      # puts 'this is happening yoyo mama'
      # flash[:notice] = "Account succesfully updated"
      home_dashboard_path
  end
end
