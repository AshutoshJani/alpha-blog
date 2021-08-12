class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy] #runs the set_action function before running these functions only
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show

    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 6)
    end

    def new
        if logged_in?
            @article = Article.new
        else
            redirect_to login_path
            flash[:notice] = "You will need to login/sign up to create new article"
        end
    end

    def edit

    end


    def create
        @article = Article.new(set_params) 

        # @article.user_id = User.first.id #Manually set the user of new articles as the first user since no authentication system yet
        @article.user = current_user

        # render plain: @article.inspect #prints out the value of @article on the browser
        
        if @article.save
            #flash is used to display 'alert' or 'notice' messages in the web page
            flash[:notice] = "Article was created successfully." #flash is a hash type data structure and is usually enables in view/layouts/application.html.erb since that is shared between all the html pages

            # redirect_to article_path(@article) #article_path is the path received from the url 
            redirect_to @article #shorter method to redirect to the newly created article
        else
            render 'new'
        end
    end

    def update
        if @article.update(set_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        flash[:notice] = "Article was deleted successfully"
        redirect_to articles_path
    end
    
    private

    def set_article
        @article = Article.find(params[:id])
    end

    def set_params
        params.require(:article).permit(:title, :description, category_ids: []) #cannot provide parameters directly due to security so need to specify the columns (this is called strong parameters and whitelisting data)
    end

    def require_same_user
        if current_user != @article.user && current_user[:admin] == false
            flash[:alert] = "You cannot edit or delete someone else's articles"
            redirect_to articles_path
        end
    end

end