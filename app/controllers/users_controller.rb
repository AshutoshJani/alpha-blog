class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(set_params)
        if @user.save
            flash[:notice] = "Welcome #{ @user.username }, you have successfully signed up for Alpha Blog"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        render plain: @user.inspect
        # if @user.update(set_params)
        #     flash[:notice] = "Your information was successfully updated"
        #     redirect_to root_path
        # else
        #     render 'edit'
        # end
    end

    private

    def set_params
        params.require(:user).permit(:username, :email, :password) #cannot provide parameters directly due to security so need to specify the columns (this is called strong parameters and whitelisting data)
    end

end