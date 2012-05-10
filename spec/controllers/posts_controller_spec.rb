require 'spec_helper'

describe PostsController do
	
	describe "GET 'index'" do
		before(:each) do
			@posts = [stub_model(Post,:title => "1"), stub_model(Post, :title => "2")]
			Post.stub(:all){ @posts }
		end

		it "assigns a list of posts" do
			Post.should_receive(:all).and_return(@posts)
			get 'index'
			assigns(:posts).should eq @posts
			response.should be_success
		end

		it "renders the template list" do
			get 'index'
			response.should render_template(:index)
		end
  end
  
  describe "GET '/posts/new'" do
  	it "should render a form to create a new post" do
	  	session[:current_user] = "toto"
  		get 'new'
  		response.should be_success
  		response.should render_template(:new)
  	end
  	
  	it "should redirect to /sessions/new if not logged" do
  		get 'new'
  		response.should redirect_to(signin_path)
  	end
  end
  
  describe "POST '/posts'" do
		it "should redirect to index if success" do
			#@post = [stub_model(Post,:title => "post1", :body => "text", :author => "toto")]
			session[:current_user] = "toto"
			@post = Post.new()
			@post.stub(:save){true}
			Post.stub(:new){ @post }
			post 'create'
			response.should redirect_to(posts_path)
		end
		
		it "should reload the form if it failed" do
			session[:current_user] = "toto"
			post 'create'
			response.should render_template(:new)
  	end
  	
  	it "should redirect to /sessions/new if not logged" do
			post 'create'
			response.should redirect_to(signin_path)
		end
  end
  
  
  describe "DELETE '/posts/:id'" do
	 	it "should delete the post if connected user is the owner" do
  		session[:current_user] = "toto"
  		@post = Post.new
  		@post.author = "toto"
  		@post.stub(:destroy){true}
  		@comments = ()
  		Comment.stub(:find_by_post_id){@comments}
  		Post.stub(:find_by_id){@post}
  		
  		delete 'destroy', :id => 666
  		response.should redirect_to(posts_path)
  		flash[:notice].should == 'Post and related comments successfully destroyed.'
  	end
  	
  	it "should return an error if the user is not the owner" do
  		@post = Post.new
  		@post.author = "toto"
  		@post.stub(:destroy){false}
  		@comments = ()
  		Comment.stub(:find_by_post_id){@comments}
  		Post.stub(:find_by_id){@post}
  		
  		delete 'destroy', :id => 666
  		response.should redirect_to(posts_path)
  		flash[:notice].should == 'ERROR : You\'re not connected with the good account.'
  	end
  end
end
