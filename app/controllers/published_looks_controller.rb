class PublishedLooksController < ApplicationController

  # GET /public-looks/
  #browse all published looks
  def index
    @tags = Look.tag_counts
    
    @looks = Look.find(:all, 
      :order => "posted DESC", 
      :conditions => ["published = ?", true] )
      
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end

  # GET /public-looks/results?query=:query
  #search all published looks  
  def results
    query = params[:query]
    unless query
      flash[:notice] = "You must enter a search term."
      redirect_to :action => 'search' and return
    else
      @look_results = Look.find(:all,
        :order => 'id DESC',
        :conditions => 
          ['published = ? AND title LIKE ?',
            true, "%#{query}%"])
      # TODO: implement search for pages, while look is published
      @user_results = User.find(:all,
        :order => 'id DESC',
        :conditions => 
          ['username LIKE ? OR display_name LIKE ? OR bio LIKE ?',
            "%#{query}%", "%#{query}%", "%#{query}%"])
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => [@look_results, @page_results, @user_results] }
    end
  end
  
  # GET /public-looks/search
  def search
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
    #debugger
    id = params[:look_id] || params[:id]
    @look = Look.find(id)

    #if look_id is nil, sets page to the first page in the look's collection, otherwise find specific page
    @page = params[:look_id].nil? ? @look.pages.first : @look.pages.select { |page| page.id == params[:id].to_i }.first
    
    if @look.published #only published looks can be viewed here
      respond_to do |format|
        format.html
        format.xml { render :xml => @look }
      end
    end
  end

  # GET /public-looks/tag/:id(tag name)
  def tag
    @tag = params[:id]
    tag = Tag.find_by_name(@tag)
    @looks = []
    tag.taggings.select {|tag| tag.taggable_type == 'Look'}.each do |tag|
      @looks << Look.find(tag.taggable_id)
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
end
