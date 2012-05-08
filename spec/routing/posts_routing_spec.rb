require 'spec_helper'

describe PostsController do 
  it "routes to #index" do 
    get('/posts').should route_to("posts#index")
  end

  it "should provide the aliast post_path for /posts" do 
    posts_path.should == '/posts'
  end
  
  it "should route / to post#index" do
  	get('/').should route_to("posts#index")
  end
  
  it "should route GET /posts/new to post#new" do
  	get('/posts/new').should route_to("posts#new")
  end
  
  it "should route POST /posts to post#create" do
  	post('/posts').should route_to("posts#create")
  end
  
  it "should route GET /posts/:id to post#show" do
  	get('/posts/22').should route_to("posts#show", :id => "22")
  end
end
