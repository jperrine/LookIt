class LooksController < ApplicationController
  before_filter :require_login
  before_filter :check_current_user_permission
	
  # GET /user/:user_id/look(.:format)
  def index
    @looks = Look.find(:all, 
      :conditions => ["ARCHIVED = ? AND USER_ID = ?", false, @current_user.id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @user_looks }
    end
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
        format.html { redirect_to user_look_url(params[:user_id], @look) }
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
      :conditions => { :archived => false,
        :user_id => params[:user_id] })
    @pages = Page.find(:all, :conditions => { :archived => false, :look_id => @look.id })
        
    respond_to do |format|
      format.html
      format.xml { render :xml => @look }
    end
  end
	
  # DELETE /user/:user_id/look/:id(.:format)
  def destroy
    @look = Look.find(params[:id])
    	
    respond_to do |format|
      if @look.destroy
        flash[:notice] = "#{@look.title} was successfully deleted."
        format.html { redirect_to :action => 'index' }
        format.xml { head :ok }
      else
        flash[:notice] = "There was an error trying to delete #{@look.title}, please try again."
        format.html { redirect_to :action => 'index' }
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
      format.html { redirect_to :action => 'index' }
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
      format.html { redirect_to :action => 'index' }
      format.xml { head :ok }
    end
  end
end
