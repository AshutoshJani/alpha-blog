module ApplicationHelper

    # functions in the appliation_helper are available to all the views but not to any of the other controllers

    def gravatar_for(user, options = { size: 80})
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
    end

    # def current_user
    #     # This function sets the value of current user once and returns the value of the current logged in user everytime its called, this reduces the calls made to the database to find current user 
    #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # end

    # def logged_in?
    #     # !! is used to create object into boolean, so if object has a value ir returns true else false
    #     !!current_user
    # end
    
end
