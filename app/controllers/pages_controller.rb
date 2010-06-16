class PagesController < ApplicationController
  before_filter :require_login
  before_filter :check_current_user_permission
  
  # GET /users/:user_id/looks/:look_id/pages(.:format)
  def index
    @look = Look.find(params[:look_id])
    redirect_to [@current_user, @look, @look.pages.first]
  end
  
  # GET /users/:user_id/looks/:look_id/pages/new(.:format)
  def new
    @look = Look.find(params[:look_id])
    @page = Page.new
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @page}
    end
  end
  
  # GET /users/:user_id/looks/:look_id/pages/:id/edit(.:format)
  def edit
    @look = Look.find(params[:look_id])
    @page = Page.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end
  
  # POST /users/:user_id/looks/:look_id/pages(.:format)
  def create
    @page = Page.new(params[:page])
    @page.look_id = params[:look_id]
    @page.posted = Time.now
    @look = Look.find(params[:look_id])
    respond_to do |format|
      if @page.save
        flash[:notice] = "#{@page.title} was successfully added to #{@page.look.title}"
        format.html { redirect_to user_look_page_url(@current_user, @page.look, @page) }
        format.xml { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => 'new' }
        format.xml { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /user/:user_id/looks/:look_id/pages/id(.:format)
  def update
    @page = Page.find(params[:id])
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = "#{@page.title} was successfully updated."
        format.html { redirect_to user_look_page_url(@current_user, @page.look, @page) }
        format.xml { render :xml => @page, :status => :updated, :location => @page }
      else
        format.html { render :action => 'edit' }
        format.xml { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /users/:user_id/looks/:look_id/pages/:id(.:format)
  def show
    @page = Page.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @page }
    end
  end
  
  # DELETE /users/:user_id/looks/:look_id/pages/:id(.:format)
  def destroy
    @page = Page.find(params[:id])
    
    respond_to do |format|
      if @page.destroy
        flash[:notice] = "#{@page.title} was successfully deleted."
        format.html { redirect_to user_look_url(@current_user, :id => params[:look_id]) }
        format.xml { head :ok }
      else
        flash[:notice] = "There was an error trying to delete #{@page.title}, please try again."
        format.html { redirect_to user_look_page_url(@current_user, @page.look, @page) }
        format.xml { head :ok }
      end
    end
  end
  
end
