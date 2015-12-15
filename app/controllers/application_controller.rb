class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) << :username
		end
	
	private
		def admin?
			if !user_signed_in? || !current_user.admin?
				flash[:error] = "접근 권한이 없습니다."
				redirect_to '/'
			end
		end
end
