class HomeController < ApplicationController  
    
  def index  
     if user_signed_in?
       @folders = current_user.folders.roots
       @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
      end
  end  
  
  def browse  
      #get the folders owned/created by the current_user  
      @current_folder = current_user.folders.find(params[:folder_id])    

      if @current_folder  

        #getting the folders which are inside this @current_folder  
        @folders = @current_folder.children  

        #We need to fix this to show files under a specific folder if we are viewing that folder  
        @assets = @current_folder.assets.order("uploaded_file_file_name desc")  

        render :action => "index"  
      else  
        flash[:error] = "Nope!"  
        redirect_to root_url  
      end  
  end
end