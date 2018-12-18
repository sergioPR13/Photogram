class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :owned_post, only: [:edit, :update, :destroy]
    
    def index
        @posts = Post.all
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Tu post ha sido creado!"
            redirect_to posts_path
        else
            flash.now[:alert] = "El post no pudo ser creado! Por favor revisa el formulario."
            render :new
        end
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        if @post.update(post_params)
            flash[:success] = "Post actualizado."
            redirect_to posts_path
          else
            flash.now[:alert] = "La Actualización falló. Por favor revisa el formulario."
            render :edit
          end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
      end
    
    private

    def owned_post
        unless current_user == @post.user
          flash[:alert] = "No es tu post!"
          redirect_to root_path
        end
      end
    
    def post_params
        params.require(:post).permit(:image, :caption)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end