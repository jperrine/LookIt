class PublishedLooksController < ApplicationController

  # GET /public-looks/
  #browse all published looks
  def index
    @looks = Look.find(:all, 
      :order => "posted DESC", 
      :conditions => ["published = ?", true] )
      
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /public-looks/search?query=:query
  #search all published looks
  def search
    query = params[:query]
    @look_results = Look.find(:all,
      :conditions => 
        ['published = true AND title LIKE ?',
        "%#{query}%"])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @look_results }
    end
  end
  
  # GET /public-looks/user/:id
  #browse looks via user
  def user
    @user = User.find(params[:id])
    @looks = Look.find(:all, 
      :conditions => 
      ["user_id = ? and published = ?",
        @user.id, true] )
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /public-looks/view/:id OR /public-looks/view/:look_id/pages/:id
  def view
    id = params[:look_id] || params[:id]
    @look = Look.find(id)

    #if look_id is nil, sets page to the first page in the look's collection, otherwise find specific page
    @page = params[:look_id].nil? ? @look.pages.first : @look.pages.select { |page| page.id.to_s == params[:id] }.first
    
    if @look.published #only published looks can be viewed here
      respond_to do |format|
        format.html
        format.xml { render :xml => @look }
      end
    end
  end

end
