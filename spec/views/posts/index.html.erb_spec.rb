require 'spec_helper'

describe "posts/index.html.erb" do
  it "displays all the posts" do
    assign(:posts, [
           stub_model(Post, :title => "sujet 1", :created_at => "2012-05-11 17:04:03.789579"),
           stub_model(Post, :title => "sujet 2", :created_at => "2012-05-11 17:04:03.789579")
          ])
    render
    rendered.should =~ /sujet 1/
    rendered.should =~ /sujet 2/
    rendered.should =~ /new post/
    rendered.should =~ /Log In/
  end
end
