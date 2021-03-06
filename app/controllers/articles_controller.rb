class ArticlesController < ApplicationController
    
    before_action :get_param, only: [:edit,:update,:destroy,:show]
    before_action :required_user, except: [:show,:index]
    before_action :required_same_user, only: [:edit,:update,:destroy]
    def new
        @article = Article.new
    end
    
    def edit
    end
    
    def destroy
       @article.destroy
       flash[:danger] = "Article was successfully deleted"
       redirect_to articles_path
    end
    
    def index
       
       @articles=Article.paginate(page: params[:page], per_page: 5)
       
    end
    
    def update
        
        if @article.update(article_params)
            
            flash[:success] = "Article was successfully updated"
            redirect_to article_path(@article)
            
        else
            
            render 'edit'
        
        end
        
    end
    
    
    def create

        @article = Article.new(article_params)
        @article.user=User.first
        
        if @article.save
           
           flash[:success] = "Article was successfully added"
           redirect_to article_path(@article)
           
        else
           
           render 'new'
        
        end

    end
 
    def show
        
    end
    
    private
    
    def get_param
        
        @article = Article.find(params[:id])
     
         
    end
    

    def article_params

        params.require(:article).permit(:title, :description)

    end
    
    def required_same_user
        
        if @article.user != current_user && !current_user.admin?
            
            flash[:danger] = "You can delete and update your own articles"
            redirect_to root_path
            
        end
        
    end
    
    
end