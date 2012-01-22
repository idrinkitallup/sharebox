class AssetsController < ApplicationController
  before_filter :authenticate_user!
  require 'open-uri' 
  
  def index
    @assets = current_user.assets
  end

  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.build      
    if params[:folder_id] #if we want to upload a file inside another folder  
      @current_folder = current_user.folders.find(params[:folder_id])  
      @asset.folder_id = @current_folder.id  
    end
  end

  def create
    @asset = current_user.assets.build(params[:asset])  
    if @asset.save  
      flash[:notice] = "Successfully uploaded the file."  
      if @asset.folder #checking if we have a parent folder for this file  
        redirect_to browse_path(@asset.folder)  #then redirect to the parent folder  
      else  
        redirect_to root_url  
      end        
    else  
      render :action => 'new'  
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id]) 
  end

  def update
    @asset = current_user.assets.find(params[:id]) 
    if @asset.update_attributes(params[:asset])
      redirect_to @asset, :notice  => "Successfully updated asset."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id])  
    @parent_folder = @asset.folder #grabbing the parent folder before deleting the record  
    @asset.destroy  
    flash[:notice] = "Successfully deleted the file."  

      #redirect to a relevant path depending on the parent folder  
    if @parent_folder  
      redirect_to browse_path(@parent_folder)  
    else  
      redirect_to root_url  
    end
  end
  
  def get  
    asset = current_user.assets.find_by_id(params[:id])  
    
    asset ||= Asset.find(params[:id]) if current_user.has_share_access?(Asset.find_by_id(params[:id]).folder)

    if asset  
      #Parse the URL for special characters first before downloading  
      data = open(URI.parse(URI.encode(asset.uploaded_file.url)))  

      #then again, use the "send_data" method to send the above binary "data" as file.  
      #send_data data, :filename => asset.uploaded_file_file_name  

      #redirect to amazon S3 url which will let the user download the file automatically  
      redirect_to asset.uploaded_file.url, :type => asset.uploaded_file_content_type  
    else  
      flash[:error] = "Nope!"  
      redirect_to root_url  
    end  
  end
  
end
