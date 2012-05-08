require 'spec_helper'

describe CommentsController do
	describe "POST /comments" do
		it "should add a comment to a post" do
			session[:current_user] = "toto"
			@comment = Comment.new
			@comment.stub(:save){true}
			Comment.stub(:new){@comment}
			post 'create'
			response.should redirect_to(posts_path)
		end
	end
end
