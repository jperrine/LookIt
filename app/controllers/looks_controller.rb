class LooksController < ApplicationController
  before_filter :require_login
  before_filter :check_current_user_permission
	
  # GET /user/:user_id/look(.:format)
  def index
    @user_looks = Look.find(:all, 
      :conditions => ["ARCHIVED = ? AND USER_ID = ?", false, @current_user.id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @user_looks }
    end
  end
	
  def new
    @look = Look.new
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
    #@look = Look.new(params[:look])
    #@look.user_id = session[:user_id]
    @look.posted = Time.now
    @look.archived = false
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
        
    respond_to do |format|
      format.html
      format.xml { render :xml => @look }
    end
  end
	
  # DELETE /user/:user_id/look/:id(.:format)
  # doesn't delete the look, only sets it to archived
  def destroy
    @look = Look.find(params[:id])
    look_name = @look.title
    @look.archived = true
    @look.save
    
    flash[:notice] = "#{look_name} was successfully deleted."
    	
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.xml { head :ok }
    end
  end
end
