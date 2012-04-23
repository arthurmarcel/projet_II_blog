class User < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	has_many :posts, :dependent => :destroy
	
	validates :login, :presence => true
	validates :login, :uniqueness => true
	validates :login_before_type_cast, :format => { :with => /^[a-z0-9_-]{4,15}$/i, :on => :create }
end
