class ApplicationController < ActionController::Base

    # functions in the application_controller are available to the other controllers but not to the views
    # To make functions here available to the views as well we use
    helper_method :current_user, :logged_in?

    def current_user
        # This function sets the value of current user once and returns the value of the current logged in user everytime its called, this reduces the calls made to the database to find current user 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        # !! is used to create object into boolean, so if object has a value ir returns true else false
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end

end
