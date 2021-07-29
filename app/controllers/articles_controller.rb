class ArticlesController < ApplicationController

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end


    def create
        @article = Article.new(params.require(:article).permit(:title, :description)) #cannot provide parameters directly due to security so need to specify the columns (this is called strong parameters and whitelisting data)
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
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:notice] = "Article was deleted successfully"
        redirect_to articles_path
    end
    
end