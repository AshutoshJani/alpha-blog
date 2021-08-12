class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 6)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 6)
    end

    def create
        @user = User.new(set_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{ @user.username }, you have successfully signed up for Alpha Blog"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        
    end

    def update
        render plain: @user.inspect
        # if @user.update(set_params)
        #     flash[:notice] = "Your information was successfully updated"
        #     redirect_to root_path
        # else
        #     render 'edit'
        # end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all associated articles have been successfully deleted"
        redirect_to root_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def set_params
        params.require(:user).permit(:username, :email, :password) #cannot provide parameters directly due to security so need to specify the columns (this is called strong parameters and whitelisting data)
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You cannot perform that action on this user"
            redirect_to users_path
        end
    end

end