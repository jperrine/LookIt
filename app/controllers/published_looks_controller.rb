class PublishedLooksController < ApplicationController

  #browse all published looks
  def index
    @looks = Look.find(:all, 
      :order => "posted DESC", 
      :limit => 10, 
      :conditions => ["published = ? AND archived = ?", true, false] )
      
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  #search all published looks
  def search
    query = params[:query]
    @look_results = Look.find(:all,
      :limit => 25,
      :conditions => 
        ['archived = false AND published = true AND (title LIKE ? OR content LIKE ?)',
        "%#{query}%", "%#{query}%"])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @look_results }
    end
  end
  
  #browse looks via user
  def user
    @user = User.find(params[:id])
    @looks = Look.find(:all, 
      :conditions => 
      ["user_id = ? and published = ? and archived = ?",
        @user.id, true, false] )
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  def view
    @look = Look.find(params[:id])
    
    if @look.published && @look.archived == false #only published/unarchived looks can be viewed here
      respond_to do |format|
        format.html
        format.xml { render :xml => @look }
      end
    end
  end

end
