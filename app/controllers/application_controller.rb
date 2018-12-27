class ApplicationController < ActionController::Base
    before_action :current_user
    before_action :must_logged_in
    
    def current_user
        token = User.encrypt(cookies[:user_token])
        @current_user ||= User.find_by(token: token)
    end
    def must_logged_in
        if !@current_user
            redirect_to '/login'
        end
    end
end
