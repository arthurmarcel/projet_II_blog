class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	
	validates :post_id, :presence => true
	validates :post_id_before_type_cast, :format => { :with => /^[0-9]{1,}$/i, :on => :create }
	validates :author, :presence => true
	validates :author_before_type_cast, :format => { :with => /^[a-z0-9_-]{4,15}$/i, :on => :create }
	validates :body, :presence => true
end
