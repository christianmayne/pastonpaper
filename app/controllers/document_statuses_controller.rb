class DocumentStatusesController < ApplicationController

def index
	@document_statuses = DocumentStatus.find(:all)
end

def show
	@document_status = DocumentStatus.find(params[:id])
end

end
