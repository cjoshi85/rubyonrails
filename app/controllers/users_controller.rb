class UsersController < ApplicationController
    
    before_action :get_user, only: [:edit,:update,:show]
    
    before_action :required_same_user, only: [:edit,:update]
    
    def new
        
        @user=User.new
        
        
    end
    
    def index
       @users=User.paginate(page: params[:page],per_page: 2) 
    end
    
    def show
       
       @user_articles=@user.articles.paginate(page: params[:page], per_page: 1)
        
    end
    
    def create
       @user = User.new(user_params)
       if @user.save
           session[:user_id] = @user.id
           flash[:success]="Welcome to the AlphaBlog"
           
           redirect_to articles_path
           
       else
           
           render 'new'
           
       end
        
    end
    
    def edit
       
    end
    
    def update
       if @user.update(user_params)
           flash[:success]="Account has been successfully updated"
           redirect_to articles_path
           
       else
           render 'edit'
           
       end
    end
    
    private
    
    def user_params
        
        params.require(:user).permit(:username,:email,:password)
        
    end
    
    def get_user
        @user=User.find(params[:id])
    end
    
    def required_same_user
        
        if @user != current_user
            flash[:danger] = "You can edit your own account only"
            redirect_to root_path
            
        end
        
    end
            
    
end