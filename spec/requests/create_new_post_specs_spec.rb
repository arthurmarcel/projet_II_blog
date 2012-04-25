require 'spec_helper'

describe "CreateNewPostSpecs" do
  describe "POST /posts" do
		it "should create the post and redirect to /posts" do
			session[:current_user] = "toto";
			visit '/'
			click_link 'Create a new post'
			page.should have_content "Post creation"
			fill_in 'Title', :with => "TitleTest"
			fill_in 'Body', :with => "blablablablablablablablablablablablablablablablablablablablablabla"
			click_button('Post it!')
			current_path.should == '/posts'
  	end
  	
  	it "should redirect to /sessions/new if not logged" do
			visit '/'
			click_link 'Create a new post'
			page.should_not have_content "Post creation"
  	end
  end
end
