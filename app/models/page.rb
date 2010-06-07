class Page < ActiveRecord::Base
  belongs_to :look
  
  validates_presence_of :title, :content, :look_id, :posted
  validates_length_of :title, :maximum => 255
  validates_length_of :content, :maximum => 10000
end
