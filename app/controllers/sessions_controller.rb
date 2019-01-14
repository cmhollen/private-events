class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(name: params[:session][:name])
        if user
            log_in user
            redirect_to user
        else
            render 'new'
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end
end
