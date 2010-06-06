class Look < ActiveRecord::Base
	belongs_to :user
	
	validates_presence_of :title, :user_id, :content, :posted
	
	validates_length_of :content, :maximum => 10000
	validates_length_of :title, :maximum => 255
	
end
