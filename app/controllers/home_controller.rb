class HomeController < ApplicationController

  def index
    @user_session = UserSession.new if @current_user.blank?
  end

  def show
  end

  def simple_people_search
    
  end

  def simple_location_search
    
  end

  def document_search
    @document_type = DocumentType.all
  end

  def search_results
    if !params[:search_people].blank?
      @documents = Document.search_people(params[:search_people])
    elsif !params[:search_location].blank?
      @documents = Document.search_location(params[:search_location])
    elsif !params[:search_document].blank?
      @documents = Document.search_document(params[:search_document])
    else
      @documents = ""
    end
#    if !params[:search_people].blank?
#      @stockitems = Stockitem.simple_search(params[:search_people])
#    elsif !params[:search_location].blank?
#      @stockitems = Stockitem.simple_search(params[:search_location])
#    elsif !params[:search_document].blank?
#      @stockitems = Stockitem.simple_search(params[:search_document])
#    end
  end

  
  
end
