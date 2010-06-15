class Page < ActiveRecord::Base
  belongs_to :look
  
  validates_presence_of :title, :content, :look_id, :posted
  validates_length_of :title, :maximum => 255
  validates_length_of :content, :maximum => 10000
  
  def to_param
    "#{id}-#{title.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
