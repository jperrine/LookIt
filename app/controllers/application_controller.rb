# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :username
  
  protected 
    def get_logged_in_user
      id = session[:user_id]
      unless id.nil?
        @current_user ||= User.find(id)
      end
      session[:user_param] = @current_user
    end
    
    def require_login
      get_logged_in_user
      if @current_user.nil?
        session[:original_uri] = request.request_uri
        flash[:notice] = "You must login first."
        redirect_to login_users_path and return
      end
    end
    
    def check_current_user_permission
      param_id = params[:user_id] == nil ? params[:id] : params[:user_id]
      if session[:user_id] != param_id.to_i
        flash[:notice] = "You don't have permission to do that."
        redirect_to root_path and return
      end
    end
end
