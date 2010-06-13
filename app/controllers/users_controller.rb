class UsersController < ApplicationController
  before_filter :require_login, :only => [:edit, :update, :destroy, :published_looks, :working_looks, :change_password]
  before_filter :check_current_user_permission, :only => [:edit, :update, :destroy, :published_looks, :working_looks, :change_password]
	
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
  
  # GET /user/new(.:format) and /
  def new
    #so logged-in users aren't greeted with a registration page
    if session[:user_id]
      redirect_to :action => 'show', :id => session[:user_id] and return
    end
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
    if params[:user][:photo]
      @user.photo = params[:user][:photo]
    end
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
  def destroy
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.destroy
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
  # GET /user/check_username?username=:username
  def check_username
    @test_username = params[:username]
    @test_user = User.find_by_username(@test_username)
    @valid = @test_user.nil?
    if request.xhr?
      render :text => @valid
    end
  end
  
  # GET /user/:id/published-looks.:format
  def published_looks
    @looks = @current_user.looks.select {|look| look.published == true }
    @user = @current_user    
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET /user/:id/working-looks.:format
  def working_looks
    @looks = @current_user.looks.select {|look| look.published == false }
    @user = @current_user
    respond_to do |format|
      format.html
      format.xml { render :xml => @looks }
    end
  end
  
  # GET || POST /user/:id/edit/password
  def change_password
    if request.post?
      #debugger
      @user = @current_user
      unless User.match_password(@user.hashed_password, params['old_password'], @user.salt)
        flash[:notice] = 'Incorrect old password.'
      else
        @user.password = params['new_password']
        @user.password_confirmation = params['new_password_confirmation']
        if @user.save
          flash[:notice] = 'Password successfully updated.'
          redirect_to @user
        else
          flash[:notice] = 'Password confirmation did not match.'
          render :action => 'change_password'
        end
      end
    else
      @user = @current_user
    end
  end
end
