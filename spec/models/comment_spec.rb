require 'spec_helper'

describe Comment do
describe "is empty" do
  	it "should not be valid" do
  		subject.valid?.should be_false
  	end
  end
  
  describe "is not complete" do
  	subject do
			c = Comment.new
			c.author = "author"
			c.post_id = "018"
			c.body = "body"
			c
		end
  
  	it "should not be valid without an author" do
  		subject.author = ""
			subject.valid?.should be_false
  	end
  	
  	it "should not be valid without a title" do
  		subject.post_id = ""
			subject.valid?.should be_false
  	end
  	
  	it "should not be valid without a body" do
  		subject.body = ""
			subject.valid?.should be_false
  	end
  end
  
  describe "is wrong" do
  	subject do
			c = Comment.new
			c.author = "author"
			c.post_id = "018"
			c.body = "body"
			c
		end
		
  	it "should not be valid with a wrong post_id" do
			subject.post_id = "abc"
  		subject.valid?.should be_false
  	end
  	
  	it "should not be valid with a wrong author" do
			subject.author = "@author@"
  		subject.valid?.should be_false
  	end
  end
  
  describe "is complete" do
  	it "should be valid with good parameters" do
			subject.author = "author"
			subject.post_id = 22
			subject.body = "body"
  		subject.valid?.should be_true
  	end
  end
end
