class Look < ActiveRecord::Base
	belongs_to :user
	has_many :pages
	
	validates_presence_of :title, :user_id, :content, :posted
	
	validates_length_of :content, :maximum => 500
	validates_length_of :title, :maximum => 255
	
end
