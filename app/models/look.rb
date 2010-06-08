class Look < ActiveRecord::Base
	belongs_to :user
	has_many :pages
	
	#paperclip
	has_attached_file :cover,
    :styles => {
        :thumb => "50x50"
    },
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => ":class/:id/:style/:filename"
	
	validates_presence_of :title, :user_id, :content, :posted
	
	validates_length_of :content, :maximum => 500
	validates_length_of :title, :maximum => 255
end
