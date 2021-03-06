class Look < ActiveRecord::Base
	belongs_to :user
	has_many :pages
	
	acts_as_taggable
	
	#paperclip
	has_attached_file :cover,
    :styles => {
        :thumb => "125x110#"
    },
    #s3 won't work on dev
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'] ? ENV['S3_KEY'] : "blah",
      :secret_access_key => ENV['S3_SECRET'] ? ENV['S3_SECRET'] : "blahtwo"
    },
    :bucket => ENV['S3_BUCKET'] ? ENV['S3_BUCKET'] : "blahbucket",
    :path => ':class/:id/:style/:filename',
    :default_url => '/images/look_cover.png',
    :default_path => '/public/images/look_cover.png'
	
	validates_presence_of :title, :user_id, :content, :posted
	
	validates_length_of :content, :maximum => 500
	validates_length_of :title, :maximum => 75
	
	def to_param
    "#{id}-#{title.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def self.find_published(page, order = 'title ASC')
    paginate(:page => page, :per_page => 5, :order => "#{order}", 
      :conditions => {:published => true}, :include => :user)
  end
  
  def self.find_working(page, order = 'title ASC')
    paginate(:page => page, :per_page => 5, :order => "#{order}", 
      :conditions => {:published => false}, :include => :user)
  end
  
  def self.find_them_all(page, order = 'title ASC')
    paginate(:page => page, :per_page => 5, :order => "#{order}", :include => :user)
  end
end
