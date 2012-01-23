class UserMailer < ActionMailer::Base
  default :from => "mathsboy@gmail.com"
      
    def invitation_to_share(shared_folder)  
            @shared_folder = shared_folder 
            mail( :to => @shared_folder.shared_email,   
                  :subject => "#{@shared_folder.user.name} wants to share '#{@shared_folder.folder.name}' folder with you" )  
    end
    
    def welcome_email(user)
        @user = user
        @url  = "http://example.com/login"
        mail(:to => user.email, :subject => "Welcome to My Awesome Site")
    end
          
          
end
