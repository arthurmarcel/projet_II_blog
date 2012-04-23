class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, :dependent => :destroy
	
	validates :author, :presence => true
	validates :author_before_type_cast, :format => { :with => /^[a-z0-9_-]{4,15}$/i, :on => :create }
	validates :title, :presence => true
	validates :body, :presence => true
end
