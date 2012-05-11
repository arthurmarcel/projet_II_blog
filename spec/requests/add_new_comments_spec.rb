require 'spec_helper'

describe "AddNewComments" do
	before(:each) do
		visit '/sessions/loginforspec'
		click_link 'Create a new post'
		page.should have_content "Post creation"
		fill_in 'Title', :with => "TitleTest"
		fill_in 'Body', :with => "blablablablaa"
		click_button('Post it!')
		current_path.should == '/posts'
	end
	
  describe "POST /comments without being logged" do
		it "should add the comment to the post with 'Anonymous' as author" do
			visit '/sessions/logoutforspec'
			fill_in 'body', :with => "test comment"
			click_button('Add it!')
			page.should have_content "Posts List"
			page.should have_content "Anonymous,"
			current_path.should == '/posts'
  	end
  end
  
	describe "POST /comments when logged" do
		it "should add the comment to the post with login as author" do
			fill_in 'body', :with => "test comment"
			click_button('Add it!')
			page.should have_content "Posts List"
			page.should have_content "toto,"
			current_path.should == '/posts'
  	end
  end
end
