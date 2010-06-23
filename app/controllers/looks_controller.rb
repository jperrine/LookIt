class LooksController < ApplicationController
  before_filter :require_login
  before_filter :check_current_user_permission
	
  # GET /user/:user_id/look(.:format)
  def index
    redirect_to @current_user
  end
	
	# GET /users/:user_id/look/new(.:format)
  def new
    @look = Look.new
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @look }
    end
  end
	
  # GET /user/:user_id/look/:id(.:format)
  def edit
    @look = Look.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @look }
    end
  end
	
  # POST /user/:user_id/look(.:format)
  def create
  	@look = @current_user.looks.build(params[:look])
    @look.published = false
    @look.posted = Time.now
    
    respond_to do |format|
      if @look.save
        flash[:notice] = "#{@look.title} was successfully created."
        format.html { redirect_to [@current_user, @look] }
        format.xml { render :xml => @look, :status => :created, :location => @look }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @look.errors, :status => :unprocessable_entity }
      end
    end
  end
	
  # PUT /user/:user_id/look/:id(.:format)
  def update
    @look = Look.find(params[:id])
    respond_to do |format|
      if @look.update_attributes(params[:look])
        flash[:notice] = "#{@look.title} was successfully updated."
        format.html { redirect_to user_look_path(@look.user, @look) }
        format.xml { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml { render :xml => @look.errors, :status => :unprocessable_entity }
      end
    end
  end
	
  # GET /user/:user_id/look/:id(.:format)
  def show
    @look = Look.find(params[:id], 
      :conditions => {:user_id => @current_user.id })
    @page = @look.pages.empty? ? @look.pages.first : nil
        
    respond_to do |format|
      format.html
      format.xml { render :xml => @look }
    end
  end
	
  # DELETE /user/:user_id/look/:id(.:format)
  def destroy
    @look = Look.find(params[:id])
    title = @look.title
    look_id = @look.id
    destroyed = @look.destroy
    
    if destroyed
      pages = Page.find(:all, :conditions => ["look_id = ?", look_id])
      pages.each do |page|
        page.destroy
      end
    end
    
    respond_to do |format|
      if destroyed
        flash[:notice] = "#{title} was successfully deleted."
        format.html { redirect_to @current_user }
        format.xml { head :ok }
      else
        flash[:notice] = "There was an error trying to delete #{title}, please try again."
        format.html { redirect_to @current_user }
        format.xml { head :ok }
      end
    end
  end
  
  # PUT /users/:user_id/looks/:id.:format/unpublish
  def unpublish
    @look = Look.find(params[:id])
    @look.published = false
    
    respond_to do |format|
      unless @look.save
        flash[:notice] = "Error processing unpublish, please try again."
      end
      format.html { redirect_to user_look_path(@current_user, @look) }
      format.xml { head :ok }
    end
  end
  
  # PUT /users/:user_id/looks/:.:format/publish
  def publish
    @look = Look.find(params[:id])
    @look.published = true
    
    respond_to do |format|
      unless @look.save
        flash[:notice] = "Error processing publish, please try again."
      end
      format.html { redirect_to user_look_path(@current_user, @look) }
      format.xml { head :ok }
    end
  end
  
  # GET /user/:id/looks/published.:format
  def published
    @user = @current_user
    @looks = @user.looks.find_published(params[:page])
    @tags = Tag.find(:all, :conditions => ['looks.published = ? and looks.user_id = ?', true, @user.id],
      :joins => ['inner join taggings on taggings.tag_id = tags.id', 
        'inner join looks on looks.id = taggings.taggable_id'])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /user/:id/looks/working-looks.:format
  def working
    @user = @current_user
    @looks = @user.looks.find_working(params[:page])
    @tags = Tag.find(:all, :conditions => ['looks.published = ? and looks.user_id = ?', false, @user.id],
      :joins => ['inner join taggings on taggings.tag_id = tags.id', 
        'inner join looks on looks.id = taggings.taggable_id'])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /users/:user_id/looks/tags/:id
  def tags
    @user = @current_user
    tag_name = params[:id]
    @looks = @user.looks.paginate(:all, :per_page => 5, :page => params[:page], :joins => 
      ['inner join taggings on taggings.taggable_id = looks.id', 'inner join tags on tags.id = taggings.tag_id'], 
        :conditions => ['tags.name = ?', tag_name])
    @tags = Tag.find(:all, :conditions => ['looks.user_id = ?', @user.id],
      :joins => ['inner join taggings on taggings.tag_id = tags.id', 
        'inner join looks on looks.id = taggings.taggable_id'])
    @tags = Look.tag_counts
  end
end
