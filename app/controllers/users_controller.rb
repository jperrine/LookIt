class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :update, :destroy]
  before_filter :check_current_user_permission, :only => [:edit, :update, :destroy]
	
  # GET /user/index(.:format)
  def index
    redirect_to :action => 'login'
  end

  # GET /user/:id(.:format)
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml { render :xml => @user }
    end
  end
  
  # GET /user/new(.:format)
  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end

  # GET /user/:id/edit(.:format)
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end

  # POST /user/
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "#{@user.display_name}, your account was successfully created."
        session[:user_id] = @user.id
        format.html { redirect_to user_looks_url(:user_id => @user.id) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user/:id
  def update
    @user = User.find(params[:id])
    User.update_settings(@user, User.new(params[:user]))
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "#{@user.display_name}, your account was successfully updated."
        format.html { redirect_to @user }
        format.xml { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user/:id
  # does not delete the user, sets active flag to false
  def destroy
    @user = User.find(params[:id])
    @user.active = false
    
    respond_to do |format|
      if @user.save 
        format.html { redirect_to root_url }
        format.xml { head :ok }
      else
        format.html { redirect_to root_url }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /login
  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        uri, session[:original_uri] = session[:original_uri], nil
        respond_to do |format|
          format.html { redirect_to(uri || user) }
          format.xml { head :ok }
        end
      else
        flash.now[:notice] = "Invalid user/password combination"
        respond_to do |format|
          format.html 
          format.xml { render :xml => "Invalid user/password combination" }
        end
      end
    else
      respond_to do |format|
        format.html
        format.xml { head :ok }
      end    
    end
  end
  
  # GET /logout
  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."
    respond_to do |format|
      format.html { redirect_to login_url }
      format.xml { head :ok }
    end
  end
  
  # AJAX action to check username availability
  def check_username
    @test_username = params[:username]
    @test_user = User.find_by_username(@test_username)
    @valid = @test_user.nil?
  end
end
