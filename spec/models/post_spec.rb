require 'spec_helper'

describe Post do
  describe "is empty" do
  	it "should not be valid" do
  		subject.valid?.should be_false
  	end
  end
  
  describe "is not complete" do
  	subject do
			p = Post.new
			p.author = "author"
			p.title = "title"
			p.body = "body"
			p
		end
  
  	it "should not be valid without an author" do
  		subject.author = ""
			subject.valid?.should be_false
  	end
  	
  	it "should not be valid without a title" do
  		subject.title = ""
			subject.valid?.should be_false
  	end
  	
  	it "should not be valid without a body" do
  		subject.body = ""
			subject.valid?.should be_false
  	end
  end
  
  describe "is wrong" do
  	it "should not be valid with a wrong author" do
			subject.author = "@author@"
			subject.title = "title"
			subject.body = "body"
  		subject.valid?.should be_false
  	end
  end
  
  describe "is complete" do
  	it "should be valid with good parameters" do
			subject.author = "author"
			subject.title = "title"
			subject.body = "body"
  		subject.valid?.should be_true
  	end
  end
end
