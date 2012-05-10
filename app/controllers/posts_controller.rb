class PostsController < ApplicationController
	
	before_filter :require_login, :only => [:create, :new]
	

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signin_path
    end
  end
  
  
  def current_user 
  	return session[:current_user]
  end  
  

	def index
		@user = current_user
		@comment = Comment.new
		@posts = Post.all
		
		@comments_list = Hash.new
		@posts.each do |post|
			@comments_list["#{post.id}"] = Comment.where(:post_id => post.id)
		end
  end
  
  
  def new
		@post = Post.new
		
		respond_to do |format|
	    format.html
	    format.js
	  end
  end
  
  
  def create
		@post = Post.new(params[:post])
		@post.author = session[:current_user]
		
	  respond_to do |format|
	    if @post.save
	      format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
	      format.js
	    else
	      format.html { render action: "new" }
	    end
	  end
  end
  
  
  def destroy
		@post = Post.find_by_id(params[:id])
  	if current_user == @post.author
			if @post.destroy
				@comments = Comment.where(:post_id => params[:id])
				@comments.each do |comment|
					if !comment.destroy
						redirect_to posts_path, notice: 'Post successfully destroyed, but errors when trying to detroy comments.'
					end
				end
				flash[:notice] = 'Post and related comments successfully destroyed.'
				respond_to do |format|
					format.html { redirect_to posts_url }
					format.js
				end
			else
				redirect_to posts_path, notice: 'Failed to destroy the post.'
			end
		else
			redirect_to posts_path, notice: 'ERROR : You\'re not connected with the good account.'
		end
  end
  
end
