class Post < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	
	validates :author, :presence => true
	validates :author_before_type_cast, :format => { :with => /^[a-z0-9_-]{4,15}$/i, :on => :create }
	validates :title, :presence => true
	validates :body, :presence => true
	
	def formatted_created_at
		self[:created_at].strftime("%d/%m/%Y %H:%M")
	end

end
