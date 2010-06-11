require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :looks

  #paperclip
  has_attached_file :photo,
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
    :default_url => '/images/user_avatar.png',
    :default_path => '/public/images/user_avatar.png'
  
  validates_presence_of :display_name, :email, :username
  validates_uniqueness_of :username, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_confirmation_of :password
  
  attr_accessor :password_confirmation
  
  validate :password_non_blank
  
  def self.authenticate(username, password)
    user = self.find_by_username(username)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  #accepts user's hashed password, the entered password and the salt, hashes the entered password and returns a boolean on if they match
  def self.match_password(users_password, entered_password, salt)
    test_pass = User.encrypted_password(entered_password, salt)
    users_password == test_pass
  end
  
  #controls what can be updated through the settings page
  #accepts a user object and 
  def self.update_settings(current, user_obj)
    current.display_name = user_obj.display_name
    current.email = user_obj.email
    current.birthdate = user_obj.birthdate
    current.photo = user_obj.photo
    current.bio = user_obj.bio
  end
    
  #password is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end  
  
  private
    def password_non_blank
      errors.add(:password, "Missing password") if hashed_password.blank?
    end
    
    def self.encrypted_password(password, salt)
      string_to_hash = password + "ILIKETOMAKEHACKINGHARD" + salt
      Digest::SHA1.hexdigest(string_to_hash)
    end
    
    def create_new_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
