class PublishedLooksController < ApplicationController

  # GET /public-looks/
  #browse all published looks
  def index
    @tags = Look.tag_counts(:conditions => ["looks.published = ?", true])
    @sort = params[:sort] || "date"
    sort = @sort == "date" ? "posted" : "title"
    @looks = Look.find_published(params[:page], sort)
      
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end

  # GET /public-looks/results?query=:query
  #search all published looks  
  def results
    @tags = Look.tag_counts(:conditions => ["looks.published = ?", true])
    @sort = params[:sort] || "date"
    sort = @sort == "date" ? "posted" : "title"
    query = params[:query]
    unless query
      flash[:notice] = "You must enter a search term."
      redirect_to :action => 'index' and return
    else
      #todo reimplement searching for only looks, but can search within pages
      @looks = Look.paginate(:page => params[:page], :per_page => 5, :order => "#{sort} DESC",
        :joins => :pages,
        :conditions => ["(lower(looks.title) LIKE ? OR lower(looks.content) LIKE ? ) AND looks.published = ?", 
           "%#{query.downcase}%", "%#{query.downcase}%", true])
      @looks = @looks.uniq
    end
    
    respond_to do |format|
      format.html
      format.xml { render :xml => [@looks] }
    end
  end
  
  # GET /public-looks/user/:id
  #browse looks via user
  def user
    @user = User.find(params[:id])
    @sort = params[:sort] || "date"
    sort = @sort == "date" ? "posted" : "title"
    @looks = @user.looks.find_published(params[:page], sort)
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /public-looks/view/:id OR /public-looks/view/:look_id/pages/:id
  def view
    #debugger
    id = params[:look_id] || params[:id]
    @look = Look.find(id, :include => [:user, :pages])

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
    @tags = Look.tag_counts(:conditions => ["looks.published = ?", true])
    @tag = params[:id]
    @sort = params[:sort] || "date"
    sort = @sort == "date" ? "posted" : "title"
    @looks = Look.paginate(:page => params[:page], :per_page => 5, 
      :joins => ["inner join taggings on taggings.taggable_id = looks.id", "inner join tags on tags.id = taggings.tag_id"], 
      :conditions => ["looks.published = ? AND tags.name = ?", true, @tag], 
      :order => "#{sort} desc ")
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
end
