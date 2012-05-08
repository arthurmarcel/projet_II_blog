require 'spec_helper'

describe "CreateNewPostSpecs" do
  describe "POST /posts" do
		it "should create the post and redirect to /posts" do
			visit '/sessions/loginforspec'
			click_link 'Create a new post'
			page.should have_content "Post creation"
			fill_in 'Title', :with => "TitleTest"
			fill_in 'Body', :with => "blablablablablablablablablablablablablablablablablablablablablabla"
			click_button('Post it!')
			current_path.should == '/posts'
  	end
  end
end
