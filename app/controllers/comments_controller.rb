class CommentsController < ApplicationController
	def create
		@comment = Comment.new({:post_id => params[:post_id], :author => params[:author], :body => params[:body]})
		
		if params[:author] != "Anonymous"
			session[:current_user] = params[:author]
		end
		
	  respond_to do |format|
	    if @comment.save
	      format.html { redirect_to posts_path, notice: 'Comment was successfully added.' }
	      format.js
	    else
	      format.html { redirect_to posts_path, notice: 'Error while adding comment.' }
	      format.js
	    end
	  end
  end
end
