require 'spec_helper'

describe "posts/new.html.erb" do
  it "display a form to create a new post" do
  	@post = Post.new
  	render
    rendered.should =~ /Post creation/
  end
end
