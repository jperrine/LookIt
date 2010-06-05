require "digest/sha1"
class User < ActiveRecord::Base
  has_many :looks

  #image_column :picture, :versions => {:thumb => "c50x50" }, :store_dir => "pictures", :filename => proc{|record, file| "picture#{record.id}.#{file.extension}"}
  
  validates_presence_of :display_name, :email, :birthdate, :username
  validates_uniqueness_of :username, :email
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
  
  #controls what can be updated through the settings page
  #accepts a user object and 
  def self.update_settings(current, user_obj)
    current.display_name = user_obj.display_name
    current.email = user_obj.email
    current.birthdate = user_obj.birthdate
    current.picture = user_obj.picture
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
