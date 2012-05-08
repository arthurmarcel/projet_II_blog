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
			response.should redirect_to(@post)
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
  
  describe "GET '/posts/:id'" do
  	it "should display post content" do
  		@post = Post.new()
  		@post.author = "tututu"
  		@post.title = "tititititititi"
  		@post.body = "tatatatatatatatatatatatatatatatatatatatatatatatata"
  		
  		Post.stub(:find_by_id){@post}
  		
  		get 'show', :id => 22
  		
  		response.should render_template(:show)
  	end
  end
  
end
