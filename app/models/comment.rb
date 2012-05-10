class Comment < ActiveRecord::Base
	belongs_to :post
	
	validates :post_id, :presence => true
	validates :post_id_before_type_cast, :format => { :with => /^[0-9]{1,}$/i, :on => :create }
	validates :author, :presence => true
	validates :author_before_type_cast, :format => { :with => /^[a-z0-9_-]{4,15}$/i, :on => :create }
	validates :body, :presence => true
	
	def formatted_created_at
		self[:created_at].strftime("%d/%m/%Y %H:%M")
	end
	
end
