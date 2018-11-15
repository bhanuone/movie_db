class ApplicationController < ActionController::Base
  layout :layout_by_resource

  before_action :configure_signup_parameters, if: :devise_controller?


  private

  def layout_by_resource
    if devise_controller?
      'devise'   
    else
      'application'
    end
  end

 def configure_signup_parameters
   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
     user_params.permit(:email, :name, :password, :password_confirmation)
   end
 end 
end
